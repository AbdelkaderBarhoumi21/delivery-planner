import 'package:get/get.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/models/vehicle_model.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/models/order_option.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/models/trip_selection_model.dart';
import 'package:flutter_ecommerce_app_v2/data/services/hive_services.dart';

class TripSheetController extends GetxController {
  TripSheetController({required this.vehicles, required this.orders});

  final List<VehicleOption> vehicles;
  final List<OrderOption> orders;

  final RxnString selectedVehicleId = RxnString();
  final RxSet<String> selectedOrderIds = <String>{}.obs;

  VehicleOption? get currentVehicle => selectedVehicleId.value == null
      ? null
      : vehicles.firstWhere((v) => v.id == selectedVehicleId.value);

  // ---- Eligibility ----
  bool _isEligible(String id) {
    final s = HiveService.statusOf(id);
    return s == 'Pending' || s == 'In-Transit' || s == 'Assigned';
  }

  // ---- Capacity (effective) ----
  double get effW => currentVehicle == null
      ? 0
      : currentVehicle!.capacityWeight * currentVehicle!.fillRate;

  double get effV => currentVehicle == null
      ? 0
      : currentVehicle!.capacityVolume * currentVehicle!.fillRate;

  double get totalCod {
    var sum = 0.0;
    for (final o in orders) {
      if (selectedOrderIds.contains(o.id)) sum += o.codAmount;
    }
    return sum;
  }

  // ---- Selected orders convenience ----
  List<OrderOption> get selectedOrders => orders
      .where((o) => selectedOrderIds.contains(o.id))
      .toList(growable: false);

  // ---- Usage ----
  double get usedW => selectedOrders.fold(0.0, (a, o) => a + o.weight);
  double get usedV => selectedOrders.fold(0.0, (a, o) => a + o.volume);

  double get pctW => effW == 0 ? 0 : (usedW / effW).clamp(0, 1);
  double get pctV => effV == 0 ? 0 : (usedV / effV).clamp(0, 1);

  double get remainingW => (effW - usedW).clamp(0, effW);
  double get remainingV => (effV - usedV).clamp(0, effV);

  bool get isOverCapacity => usedW > effW || usedV > effV;

  String get overReason {
    if (currentVehicle == null) return '';
    if (usedW > effW && usedV > effV) return 'Over effective capacity (Weight & Volume).';
    if (usedW > effW) return 'Over effective weight capacity.';
    if (usedV > effV) return 'Over effective volume capacity.';
    return '';
  }

  // ---- Mutations ----
  void selectVehicle(String id) => selectedVehicleId.value = id;

  /// toggle simple (no capacity block) — but reject ineligible orders
  void toggleOrder(String id, bool select) {
    if (!select) {
      selectedOrderIds.remove(id);
      return;
    }
    if (!_isEligible(id)) return; // ignore completed/cancelled
    selectedOrderIds.add(id);
  }

  /// toggle "safe": checks capacity and eligibility, returns false if refused
  bool tryToggleOrder(String id, bool select) {
    if (!select) {
      selectedOrderIds.remove(id);
      return true;
    }
    if (!_isEligible(id)) return false; // not allowed
    final ord = _findOrder(id);
    if (ord == null) return false;
    if (currentVehicle == null) return false;

    final newW = usedW + ord.weight;
    final newV = usedV + ord.volume;
    final canAdd = newW <= effW && newV <= effV;

    if (canAdd) selectedOrderIds.add(id);
    return canAdd;
  }

  /// replace selection (e.g., "Select all")
  void setSelectedOrders(Iterable<String> ids) {
    selectedOrderIds
      ..clear()
      ..addAll(ids.where(_isEligible)); // keep only eligible
  }

  bool get canSave =>
      selectedVehicleId.value != null &&
      selectedOrderIds.isNotEmpty &&
      !isOverCapacity;

  // ---- Build final selection ----
  TripSelection toTripSelection() => TripSelection(
        vehicleId: selectedVehicleId.value!,
        orderIds: selectedOrderIds.toList(growable: false),
      );

  // ---- Helpers ----
  OrderOption? _findOrder(String id) {
    for (final o in orders) {
      if (o.id == id) return o;
    }
    return null;
  }
}
