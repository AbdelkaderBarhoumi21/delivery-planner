// lib/features/shop/screens/order/order_trip_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/rounded_container.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/models/order_trip_track_model.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/order/order_tracking_screen.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_ecommerce_app_v2/common/styles/padding.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/appbar/appbar.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';

import 'package:flutter_ecommerce_app_v2/test_data.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/models/vehicle_model.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/models/order_option.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/models/trip_selection_model.dart';

import 'package:flutter_ecommerce_app_v2/features/shop/controllers/order/order_map_controller.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/controllers/order/trip_controller.dart';

import 'package:flutter_ecommerce_app_v2/features/shop/screens/order/widgets/order_tripplanner_map.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/bottom_sheet/trip_bottom_sheet.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class OrderTripScreen extends StatefulWidget {
  const OrderTripScreen({super.key});

  @override
  State<OrderTripScreen> createState() => _OrderTripScreenState();
}

class _OrderTripScreenState extends State<OrderTripScreen> {
  late final TripSheetController ctrl;
  final _money = NumberFormat.simpleCurrency(decimalDigits: 2);

  static const LatLng kDepot = LatLng(35.8369, 10.5925);

  // demo coordinates for orders
  final Map<String, LatLng> orderCoords = const {
    'ORD-001': LatLng(35.8600, 10.6000),
    'ORD-002': LatLng(35.8200, 10.5200),
  };

  List<VehicleOption> get vehicles => TestData.vehicles;
  List<OrderOption> get orders => TestData.orders;

  OrdersTripMapController get mapCtrl => OrdersTripMapController.instance;

  @override
  void initState() {
    super.initState();
    ctrl = Get.put(
      TripSheetController(vehicles: vehicles, orders: orders),
      tag: 'trip_screen_controller',
    );
    if (!Get.isRegistered<OrdersTripMapController>()) {
      Get.put(OrdersTripMapController());
    }
    mapCtrl
      ..setVehicle(kDepot)
      ..setOrder1(null)
      ..setOrder2(null);
  }

  @override
  void dispose() {
    Get.delete<TripSheetController>(tag: 'trip_screen_controller', force: true);
    super.dispose();
  }

  Future<void> _planTrip() async {
    final TripSelection? sel = await TripBottomSheet.show(
      context,
      vehicles: vehicles,
      orders: orders,
    );
    if (sel == null) return;

    final v = vehicles.firstWhere((x) => x.id == sel.vehicleId);
    double usedW = 0, usedV = 0;
    for (final o in orders.where((o) => sel.orderIds.contains(o.id))) {
      usedW += o.weight;
      usedV += o.volume;
    }

    mapCtrl.applyTripSelection(
      vehicleName: v.name,
      usedWeight: usedW,
      usedVolume: usedV,
      orderIds: sel.orderIds,
      coords: orderCoords,
      vehiclePos: kDepot,
      totalCod: orders
          .where((o) => sel.orderIds.contains(o.id))
          .fold(0.0, (sum, o) => sum + o.codAmount),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = AppHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: UAppBar(
        title: Text('Order Trip', style: theme.textTheme.headlineMedium),
        showBackArrow: true,
      ),
      body: Padding(
        padding: AppPadding.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1) Map
            const AppOrderTripMap(),
            const SizedBox(height: AppSizes.spaceBtwItems),

            // 2) List of trip cards (grows, stays on screen)
            Expanded(
              child: Obx(() {
                final items = mapCtrl.trips;
                if (items.isEmpty) {
                  return Center(
                    child: Text(
                      'No trips yet. Tap "Plan a Trip" below.',
                      style: theme.textTheme.bodyMedium,
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.only(bottom: 8),
                  itemCount: items.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSizes.spaceBtwItems),
                  itemBuilder: (_, i) {
                    final t = items[i];
                    return AppRoundedContainer(
                      showBorder: true,
                      backgroundColor: dark ? AppColors.dark : AppColors.light,
                      padding: const EdgeInsets.all(AppSizes.md),
                      child: Column(
                        children: [
                          // Header: vehicle
                          Row(
                            children: [
                              const Icon(Iconsax.truck), // vehicle
                              const SizedBox(width: AppSizes.spaceBtwItems / 2),
                              Text('Trip ${t.id}'),
                              const Spacer(),
                              Text(t.vehicleName),
                            ],
                          ),
                          const SizedBox(height: AppSizes.spaceBtwItems / 2),

                          // Weight
                          Row(
                            children: [
                              const Icon(Iconsax.weight), // weight
                              const SizedBox(width: AppSizes.spaceBtwItems / 2),
                              const Text('Weight'),
                              const Spacer(),
                              Text('${t.usedWeight.toStringAsFixed(1)} kg'),
                            ],
                          ),
                          const SizedBox(height: AppSizes.spaceBtwItems / 2),

                          // Volume
                          Row(
                            children: [
                              const Icon(Iconsax.box), // volume
                              const SizedBox(width: AppSizes.spaceBtwItems / 2),
                              const Text('Volume'),
                              const Spacer(),
                              Text('${t.usedVolume.toStringAsFixed(2)} m³'),
                            ],
                          ),
                          const SizedBox(height: AppSizes.spaceBtwItems / 2),

                          // COD (NEW)
                          Row(
                            children: [
                              const Icon(Iconsax.money), // COD
                              const SizedBox(width: AppSizes.spaceBtwItems / 2),
                              const Text('COD'),
                              const Spacer(),
                              Text(_money.format(t.totalCod)), // e.g. $350.00
                            ],
                          ),
                          const SizedBox(height: AppSizes.spaceBtwItems / 2),

                          // Orders
                          Row(
                            children: [
                              const Icon(Iconsax.bag), // orders list
                              const SizedBox(width: AppSizes.spaceBtwItems / 2),
                              const Text('Orders'),
                              const Spacer(),
                              Text(t.orderIds.join(', ')),
                            ],
                          ),
                          TextButton(
                            onPressed: () => Get.to(() => OrdersTrackingScreen(),arguments: TripTrackArgs(tripId: t.id, orderIds: t.orderIds)),
                            child: Text(
                              "Track",
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .apply(color: AppColors.primary),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.playlist_add),
                label: const Text('Plan a Trip'),
                onPressed: _planTrip,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
