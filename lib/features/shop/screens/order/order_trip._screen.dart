// lib/features/shop/screens/order/order_trip_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/progress%20bar/progress_bar_widget.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/controllers/order/order_map_controller.dart'
    show OrdersTripMapController;
import 'package:flutter_ecommerce_app_v2/features/shop/screens/order/stepper.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/order/widgets/order_trip_bottomsheet.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/order/widgets/order_tripplanner_map.dart';
import 'package:get/get.dart';

import 'package:flutter_ecommerce_app_v2/features/shop/controllers/order/trip_controller.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/models/trip_selection_model.dart';

import 'package:flutter_ecommerce_app_v2/common/styles/padding.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/appbar/appbar.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/button/elevated_button.dart';

import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';
import 'package:flutter_ecommerce_app_v2/test_data.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderTripScreen extends StatefulWidget {
  const OrderTripScreen({super.key});

  @override
  State<OrderTripScreen> createState() => _OrderTripScreenState();
}

class _OrderTripScreenState extends State<OrderTripScreen> {
  late final TripSheetController ctrl;

  // Dépôt (exemple Sousse — adapte si tu veux)
  static const LatLng kDepot = LatLng(35.8369, 10.5925);

  @override
  void initState() {
    super.initState();
    // Trip planner controller (GetX)
    ctrl = Get.put(
      TripSheetController(vehicles: TestData.vehicles, orders: TestData.orders),
      tag: 'trip_screen_controller',
    );
    if (!Get.isRegistered<OrdersTripMapController>()) {
      Get.put(OrdersTripMapController());
    }
    // Option : placer le véhicule au dépôt
    OrdersTripMapController.instance.setVehicle(const LatLng(35.8369, 10.5925));
    // Positionner le véhicule (marker) au dépôt au démarrage
    OrdersTripMapController.instance.setVehicle(kDepot);
    // Nettoyer les orders au démarrage
    OrdersTripMapController.instance
      ..setOrder1(null)
      ..setOrder2(null);
  }

  @override
  void dispose() {
    Get.delete<TripSheetController>(tag: 'trip_screen_controller', force: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: UAppBar(
        title: Text('Order Trip', style: theme.textTheme.headlineMedium),
        showBackArrow: true,
      ),
      body: Padding(
        padding: AppPadding.screenPadding,
        child: Obx(() {
          final chosenNames = ctrl.orders
              .where((o) => ctrl.selectedOrderIds.contains(o.id))
              .map((o) => o.displayName)
              .toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---- Google Map (via AppOrderMap) ----
              const AppOrderTripMap(),
              const SizedBox(height: AppSizes.spaceBtwItems),

              // ---- Trip Planner panel ----
              Text('Plan a Trip', style: theme.textTheme.titleMedium),
              const SizedBox(height: AppSizes.spaceBtwItems),

              // Vehicle
              Text('Vehicle', style: theme.textTheme.labelLarge),
              const SizedBox(height: AppSizes.spaceBtwItems),
              AppVehicleChoiceChip(ctrl: ctrl, theme: theme, kDepot: kDepot),

              const SizedBox(height: AppSizes.spaceBtwItems),
              if (ctrl.currentVehicle != null) ...[
                ProgressBar(
                  theme: theme,
                  label:
                      'Weight ${ctrl.usedW.toStringAsFixed(1)} / ${ctrl.effW.toStringAsFixed(1)} kg',
                  value: ctrl.pctW,
                ),
                const SizedBox(height: AppSizes.spaceBtwItems / 2),
                ProgressBar(
                  theme: theme,
                  label:
                      'Volume ${ctrl.usedV.toStringAsFixed(2)} / ${ctrl.effV.toStringAsFixed(2)} m³',
                  value: ctrl.pctV,
                ),
              ],
              const SizedBox(height: AppSizes.spaceBtwItems),

              // Orders
              Text('Orders', style: theme.textTheme.labelLarge),
              const SizedBox(height: AppSizes.spaceBtwItems),
              GestureDetector(
                onTap: () => OrderTripBottomsheet.pickOrders(context),
                child: AppOrderChoice(theme: theme, chosenNames: chosenNames),
              ),

              const Spacer(),
              // Save Trip
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: ctrl.canSave
                      ? () {
                          final result = TripSelection(
                            vehicleId: ctrl.selectedVehicleId.value!,
                            orderIds: ctrl.selectedOrderIds.toList(),
                          );
                          Get.snackbar(
                            'Trip saved',
                            'Vehicle: ${result.vehicleId} • Orders: ${result.orderIds.length}',
                          );
                          Get.to(() => CustomStepper());
                        }
                      : null,
                  child: const Text('Save Trip'),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
            ],
          );
        }),
      ),
    );
  }
}

class AppOrderChoice extends StatelessWidget {
  const AppOrderChoice({
    super.key,
    required this.theme,
    required this.chosenNames,
  });

  final ThemeData theme;
  final List<String> chosenNames;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          hintStyle: theme.textTheme.labelMedium,
          hintText: chosenNames.isEmpty
              ? 'Tap to choose orders'
              : chosenNames.join(', '),
          prefixIcon: const Icon(Icons.receipt_long_outlined),
          suffixIcon: const Icon(Icons.expand_more),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}

class AppVehicleChoiceChip extends StatelessWidget {
  const AppVehicleChoiceChip({
    super.key,
    required this.ctrl,
    required this.theme,
    required this.kDepot,
  });

  final TripSheetController ctrl;
  final ThemeData theme;
  final LatLng kDepot;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: ctrl.vehicles.map((v) {
        final selected = ctrl.selectedVehicleId.value == v.id;
        return ChoiceChip(
          backgroundColor: AppHelperFunctions.isDarkMode(context)
              ? AppColors.dark
              : AppColors.white,
          selectedColor: theme.primaryColor,
          checkmarkColor: AppColors.light,
          selected: selected,
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.local_shipping,
                size: AppSizes.iconSm,
                color: selected ? AppColors.light : AppColors.darkGrey,
              ),
              const SizedBox(width: 6),
              Text(
                v.name,
                style: selected
                    ? theme.textTheme.labelMedium!.apply(color: AppColors.light)
                    : theme.textTheme.labelMedium!.apply(
                        color: AppColors.darkerGrey,
                      ),
              ),
            ],
          ),
          onSelected: (_) {
            ctrl.selectVehicle(v.id);
            // 👉 Place / replace le véhicule sur la carte (ex: dépôt)
            OrdersTripMapController.instance.setVehicle(kDepot);
          },
        );
      }).toList(),
    );
  }
}
