import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:flutter_ecommerce_app_v2/data/services/hive_services.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/models/vehicle_model.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/models/order_option.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/models/trip_selection_model.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/models/order_trip_track_model.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/order/order_tracking_screen.dart';

import 'package:flutter_ecommerce_app_v2/features/shop/controllers/order/trip_controller.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/controllers/order/order_map_controller.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/bottom_sheet/trip_bottom_sheet.dart';

class OrderTripScreenController extends GetxController {
  static const _sheetTag = 'trip_screen_controller';

  /// Expose the currency formatter (used by the UI)
  final NumberFormat money = NumberFormat.simpleCurrency(decimalDigits: 2);

  /// Controllers used by the screen (kept exactly as before)
  late final TripSheetController sheetCtrl;
  late final OrdersTripMapController mapCtrl;

  /// Build-time options (from Hive)
  late final List<VehicleOption> vehicles;
  late final List<OrderOption> orders;

  @override
  void onInit() {
    super.onInit();

    // Build options from Hive (same logic)
    vehicles = HiveService.vehicleOptions()
        .map((v) => VehicleOption(
              id: v['id'] as String,
              name: v['name'] as String,
              capacityWeight: ((v['capacity'] as Map)['weight'] as num).toDouble(),
              capacityVolume: ((v['capacity'] as Map)['volume'] as num).toDouble(),
              fillRate: (v['fillRate'] as num).toDouble(),
            ))
        .toList(growable: false);

    orders = HiveService.orderOptions()
        .map(OrderOption.fromHive)
        .toList(growable: false);

    // Create TripSheetController (same tag & contents as before)
    sheetCtrl = Get.put(
      TripSheetController(vehicles: vehicles, orders: orders),
      tag: _sheetTag,
    );

    // Single instance of the map controller (exact behavior preserved)
    mapCtrl = Get.isRegistered<OrdersTripMapController>()
        ? Get.find<OrdersTripMapController>()
        : Get.put(OrdersTripMapController(), permanent: true);
  }

  @override
  void onClose() {
    // Mirror the previous dispose()
    if (Get.isRegistered<TripSheetController>(tag: _sheetTag)) {
      Get.delete<TripSheetController>(tag: _sheetTag, force: true);
    }
    super.onClose();
  }

  /// Was `_planTrip()` on the StatefulWidget.
  Future<void> planTrip(BuildContext context) async {
    final TripSelection? sel = await TripBottomSheet.show(
      context,
      vehicles: sheetCtrl.vehicles,
      orders: sheetCtrl.orders,
    );
    if (sel == null) return;

    final v = sheetCtrl.vehicles.firstWhere((x) => x.id == sel.vehicleId);
    await mapCtrl.createTrip(
      vehicleId: v.id,
      vehicleName: v.name,
      orderIds: sel.orderIds,
    );
  }

  void selectTrip(String tripId) => mapCtrl.selectTrip(tripId);

  void openTracking(String tripId, List<String> orderIds) {
    Get.to(
      () => const OrdersTrackingScreen(),
      arguments: TripTrackArgs(tripId: tripId, orderIds: orderIds),
    );
  }
}
