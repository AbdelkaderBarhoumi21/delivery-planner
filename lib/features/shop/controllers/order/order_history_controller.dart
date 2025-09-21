import 'package:flutter_ecommerce_app_v2/features/shop/models/order_trip_track_model.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/models/trip_model.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/order/order_tracking_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_ecommerce_app_v2/servies/hive_services.dart';

class OrderHistoryController extends GetxController {
  static OrderHistoryController get instance => Get.find();

  final active = <HistoryItemVM>[].obs;
  final completed = <HistoryItemVM>[].obs;
  final cancelled = <HistoryItemVM>[].obs;

  @override
  void onInit() {
    super.onInit();
    _refresh();

    // Auto-refresh when UI/status or trips change.
    HiveService.watchUi().listen((_) => _refresh());
    HiveService.watchTrips().listen((_) => _refresh());
  }

  /// Open the OrdersTrackingScreen focused on [orderId].
  /// If no trip contains the order, create an ad-hoc trip for it.
  Future<void> openInTracking(String orderId) async {
    // 1) try to find a trip that already contains this order
    final trip = _findTripContainingOrder(orderId);

    TripData target;
    if (trip != null) {
      target = trip;
    } else {
      // 2) build a 1-order ad-hoc trip with status from Home/UI status
      final status = HiveService.statusOf(
        orderId,
      ); // "Pending" | "In-Transit" | ...
      final v = _firstVehicle() ?? ({'id': 'v01', 'name': 'Vehicle'});

      final stop = TripStop(
        orderId: orderId,
        status: status == 'In-Transit'
            ? StopStatus.inTransit
            : StopStatus.pending,
      );

      target = TripData(
        id: 'trip_${DateTime.now().microsecondsSinceEpoch.toRadixString(36)}',
        vehicleId: v['id'] as String,
        vehicleName: v['name'] as String,
        usedWeight: 0,
        usedVolume: 0,
        totalCod:
            (HiveService.orderRawById(orderId)?['codAmount'] as num?)
                ?.toDouble() ??
            0.0,
        stops: [stop],
        currentIndex: 0,
      );

      await HiveService.upsertTrip(target);
    }

    // 3) Navigate
    Get.to(
      () => const OrdersTrackingScreen(),
      arguments: TripTrackArgs(
        tripId: target.id,
        orderIds: target.stops.map((s) => s.orderId).toList(growable: false),
      ),
    );
  }

  TripData? _findTripContainingOrder(String orderId) {
    final raw = HiveService.getAllTripsRaw();
    for (final m in raw) {
      final t = TripData.fromMap(m);
      if (t.stops.any((s) => s.orderId == orderId)) return t;
    }
    return null;
  }

  Map<String, dynamic>? _firstVehicle() {
    final vs = HiveService.vehicleOptions();
    if (vs.isEmpty) return null;
    return vs.first;
  }

  void _refresh() {
    final ids = HiveService.assignedOrderIds();
    final shipDate = HiveService.shippingDate();

    final a = <HistoryItemVM>[];
    final c = <HistoryItemVM>[];
    final x = <HistoryItemVM>[];

    for (final id in ids) {
      final order = HiveService.orderById(id);
      if (order == null) continue;

      final status = HiveService.statusOf(
        id,
      ); // 'Pending', 'In-Transit', 'Completed', 'Failed', 'Cancelled', 'Accepted'
      final custName = HiveService.customerName(order['customerId'] as String);

      final vm = HistoryItemVM(
        id: id,
        status: status,
        customerName: custName,
        shippingDate: shipDate,
      );

      if (_isCompleted(status)) {
        c.add(vm);
      } else if (_isCancelled(status)) {
        x.add(vm);
      } else {
        a.add(
          vm,
        ); // Active = Pending / In-Transit / Accepted (anything not completed/cancelled)
      }
    }

    // Most-recent first (optional)
    int byIdDesc(HistoryItemVM l, HistoryItemVM r) => r.id.compareTo(l.id);
    a.sort(byIdDesc);
    c.sort(byIdDesc);
    x.sort(byIdDesc);

    active.value = a;
    completed.value = c;
    cancelled.value = x;
  }

  bool _isCompleted(String s) => s == 'Completed' || s == 'Delivered';
  bool _isCancelled(String s) => s == 'Cancelled' || s == 'Failed';
}

class HistoryItemVM {
  final String id;
  final String status; // "Pending", "In-Transit", etc.
  final DateTime shippingDate;
  final String customerName;
  HistoryItemVM({
    required this.id,
    required this.status,
    required this.shippingDate,
    required this.customerName,
  });
}
