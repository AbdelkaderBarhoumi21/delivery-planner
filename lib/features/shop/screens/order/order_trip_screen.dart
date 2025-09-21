import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/rounded_container.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/models/order_trip_track_model.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/order/order_tracking_screen.dart';
import 'package:flutter_ecommerce_app_v2/servies/hive_services.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:iconsax/iconsax.dart';

import 'package:flutter_ecommerce_app_v2/common/styles/padding.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/appbar/appbar.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';

import 'package:flutter_ecommerce_app_v2/features/shop/models/vehicle_model.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/models/order_option.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/models/trip_selection_model.dart';

import 'package:flutter_ecommerce_app_v2/features/shop/controllers/order/order_map_controller.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/controllers/order/trip_controller.dart';

import 'package:flutter_ecommerce_app_v2/common/widget/bottom_sheet/trip_bottom_sheet.dart';
import 'widgets/order_tripplanner_map.dart';

class OrderTripScreen extends StatefulWidget {
  const OrderTripScreen({super.key});
  @override
  State<OrderTripScreen> createState() => _OrderTripScreenState();
}

class _OrderTripScreenState extends State<OrderTripScreen> {
  late final TripSheetController ctrl;
  late final OrdersTripMapController mapCtrl;
  final _money = NumberFormat.simpleCurrency(decimalDigits: 2);

  @override
  void initState() {
    super.initState();

    // Build options from Hive (strongly typed)
    final vOpts = HiveService.vehicleOptions()
        .map((v) => VehicleOption(
              id: v['id'] as String,
              name: v['name'] as String,
              capacityWeight:
                  ((v['capacity'] as Map)['weight'] as num).toDouble(),
              capacityVolume:
                  ((v['capacity'] as Map)['volume'] as num).toDouble(),
              fillRate: (v['fillRate'] as num).toDouble(),
            ))
        .toList(growable: false);

    final oOpts = HiveService.orderOptions()
        .map(OrderOption.fromHive)
        .toList(growable: false);

    ctrl = Get.put(
      TripSheetController(vehicles: vOpts, orders: oOpts),
      tag: 'trip_screen_controller',
    );

    // Single instance of the map controller for this screen
    mapCtrl = Get.isRegistered<OrdersTripMapController>()
        ? Get.find<OrdersTripMapController>()
        : Get.put(OrdersTripMapController(), permanent: true);
  }

  Future<void> _planTrip() async {
    final TripSelection? sel = await TripBottomSheet.show(
      context,
      vehicles: ctrl.vehicles,
      orders: ctrl.orders,
    );
    if (sel == null) return;

    final v = ctrl.vehicles.firstWhere((x) => x.id == sel.vehicleId);

    await mapCtrl.createTrip(
      vehicleId: v.id,
      vehicleName: v.name,
      orderIds: sel.orderIds,
    );
  }

  @override
  void dispose() {
    Get.delete<TripSheetController>(tag: 'trip_screen_controller', force: true);
    super.dispose();
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
            // Map
            AppOrderTripMap(controller: mapCtrl),
            const SizedBox(height: AppSizes.spaceBtwItems),

            // Trip cards
            Expanded(
              child: Obx(() {
                /// IMPORTANT : on n’affiche que les trips actifs
                final items = mapCtrl.activeTrips;
                final selectedId = mapCtrl.selectedTripId.value;

                if (items.isEmpty) {
                  return Center(
                    child: Text(
                      'No active trips. Tap "Plan a Trip" below.',
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
                    final bool isSelected = t.id == selectedId;

                    final Color cardBg = isSelected
                        ? AppColors.primary
                        : (dark ? AppColors.dark : AppColors.light);
                    final Color headText =
                        isSelected ? Colors.white : (dark ? Colors.white : Colors.black87);
                    final Color subText =
                        isSelected ? Colors.white70 : AppColors.darkerGrey;

                    return GestureDetector(
                      onTap: () => mapCtrl.selectTrip(t.id),
                      child: AppRoundedContainer(
                        showBorder: true,
                        backgroundColor: cardBg,
                        padding: const EdgeInsets.all(AppSizes.md),
                        child: DefaultTextStyle(
                          style: theme.textTheme.bodyMedium!.copyWith(color: headText),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Iconsax.truck, color: headText),
                                  const SizedBox(width: AppSizes.spaceBtwItems / 2),
                                  Text('Trip ${t.id}'),
                                  const Spacer(),
                                  Text(t.vehicleName),
                                ],
                              ),
                              const SizedBox(height: AppSizes.spaceBtwItems / 2),

                              Row(
                                children: [
                                  Icon(Iconsax.weight, color: headText),
                                  const SizedBox(width: AppSizes.spaceBtwItems / 2),
                                  Text('Weight',
                                      style: theme.textTheme.bodyMedium!
                                          .copyWith(color: subText)),
                                  const Spacer(),
                                  Text('${t.usedWeight.toStringAsFixed(1)} kg'),
                                ],
                              ),
                              const SizedBox(height: AppSizes.spaceBtwItems / 2),

                              Row(
                                children: [
                                  Icon(Iconsax.box, color: headText),
                                  const SizedBox(width: AppSizes.spaceBtwItems / 2),
                                  Text('Volume',
                                      style: theme.textTheme.bodyMedium!
                                          .copyWith(color: subText)),
                                  const Spacer(),
                                  Text('${t.usedVolume.toStringAsFixed(2)} m³'),
                                ],
                              ),
                              const SizedBox(height: AppSizes.spaceBtwItems / 2),

                              Row(
                                children: [
                                  Icon(Iconsax.money, color: headText),
                                  const SizedBox(width: AppSizes.spaceBtwItems / 2),
                                  Text('COD',
                                      style: theme.textTheme.bodyMedium!
                                          .copyWith(color: subText)),
                                  const Spacer(),
                                  Text(_money.format(t.totalCod)),
                                ],
                              ),
                              const SizedBox(height: AppSizes.spaceBtwItems / 2),

                              Row(
                                children: [
                                  Icon(Iconsax.bag, color: headText),
                                  const SizedBox(width: AppSizes.spaceBtwItems / 2),
                                  Text('Orders',
                                      style: theme.textTheme.bodyMedium!
                                          .copyWith(color: subText)),
                                  const Spacer(),
                                  Text(t.orderIds.join(', ')),
                                ],
                              ),

                              TextButton(
                                onPressed: () => Get.to(
                                  () => const OrdersTrackingScreen(),
                                  arguments: TripTrackArgs(
                                    tripId: t.id,
                                    orderIds: t.orderIds,
                                  ),
                                ),
                                child: Text(
                                  'Track',
                                  style: theme.textTheme.bodyMedium!.apply(
                                    color: isSelected
                                        ? Colors.white
                                        : AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
