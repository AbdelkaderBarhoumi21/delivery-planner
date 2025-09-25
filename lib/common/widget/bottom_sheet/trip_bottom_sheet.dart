import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/controllers/order/trip_controller.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/models/trip_selection_model.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:flutter_ecommerce_app_v2/common/styles/padding.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/button/elevated_button.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';

import 'package:flutter_ecommerce_app_v2/features/shop/models/vehicle_model.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/models/order_option.dart';
import 'package:flutter_ecommerce_app_v2/data/services/hive_services.dart';

class TripBottomSheet {
  static Future<TripSelection?> show(
    BuildContext context, {
    required List<VehicleOption> vehicles,
    required List<OrderOption> orders,
  }) async {
    final theme = Theme.of(context);
    final dark = AppHelperFunctions.isDarkMode(context);

    final tag = 'trip_sheet_${UniqueKey()}';
    final ctrl = Get.put(
      TripSheetController(vehicles: vehicles, orders: orders),
      tag: tag,
    );

    TripSelection? result;

    // Eligible orders: exclude completed/cancelled
    bool isEligible(String id) {
      final s = HiveService.statusOf(id);
      return s == 'Pending' || s == 'In-Transit' || s == 'Assigned';
    }

    Future<void> pickOrders() async {
      final eligible =
          orders.where((o) => isEligible(o.id)).toList(growable: false);
      final tmp = <String>{
        for (final id in ctrl.selectedOrderIds)
          if (isEligible(id)) id,
      };

      final ok = await Get.bottomSheet<bool>(
        Container(
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Padding(
            padding: AppPadding.screenPadding,
            child: StatefulBuilder(
              builder: (context, setSheet) {
                double localCod = 0;
                for (final o in eligible) {
                  if (tmp.contains(o.id)) localCod += o.codAmount;
                }
                final selectedCount = tmp.length;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text('Select Orders ($selectedCount selected)',
                              style: theme.textTheme.titleMedium),
                        ),
                        IconButton(
                          onPressed: () => Get.back(result: false),
                          icon: Icon(Icons.close,
                              color: dark ? Colors.white : Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            tmp
                              ..clear()
                              ..addAll(eligible.map((o) => o.id));
                            setSheet(() {});
                          },
                          icon: Icon(Icons.select_all, color: AppColors.primary),
                          label: Text('Select all',
                              style: Theme.of(context).textTheme.labelLarge),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            tmp.clear();
                            setSheet(() {});
                          },
                          icon: const Icon(Icons.clear_all,
                              color: AppColors.primary),
                          label: Text('Clear',
                              style: Theme.of(context).textTheme.labelLarge),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.spaceBtwItems / 4),
                    Wrap(
                      spacing: AppSizes.spaceBtwItems / 2,
                      runSpacing: AppSizes.spaceBtwItems / 2,
                      children: eligible.map((o) {
                        final checked = tmp.contains(o.id);
                        return FilterChip(
                          backgroundColor:
                              dark ? AppColors.dark : AppColors.light,
                          selectedColor: Theme.of(context).primaryColor,
                          checkmarkColor: AppColors.light,
                          label: Text(
                            '${o.displayName}  •  \$${o.codAmount.toStringAsFixed(2)}',
                            style: checked
                                ? Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .apply(color: AppColors.light)
                                : Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .apply(color: AppColors.darkerGrey),
                          ),
                          selected: checked,
                          onSelected: (val) {
                            val ? tmp.add(o.id) : tmp.remove(o.id);
                            setSheet(() {});
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwSections / 2),
                    AppElevatedButton(
                      onPressed: () => Get.back(result: true),
                      child: Text(
                          'Confirm  (Total COD: \$${localCod.toStringAsFixed(2)})'),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwSections / 2),
                  ],
                );
              },
            ),
          ),
        ),
        isScrollControlled: true,
      );

      if (ok == true) {
        ctrl.setSelectedOrders(tmp);
      }
    }

    await Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: AppPadding.screenPadding,
          child: Obx(() {
            final chosenNames = ctrl.orders
                .where((o) => ctrl.selectedOrderIds.contains(o.id))
                .map((o) => o.displayName)
                .toList();

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Expanded(
                      child: Text('Plan a Trip',
                          style: theme.textTheme.titleMedium),
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(Icons.close,
                          color: dark ? Colors.white : Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwItems / 2),

                // VEHICLE chips
                Text('Vehicle', style: theme.textTheme.labelLarge),
                const SizedBox(height: AppSizes.spaceBtwItems),
                Wrap(
                  spacing: AppSizes.spaceBtwItems / 2,
                  runSpacing: AppSizes.spaceBtwItems / 2,
                  children: ctrl.vehicles.map((v) {
                    final selected = ctrl.selectedVehicleId.value == v.id;
                    return ChoiceChip(
                      backgroundColor:
                          dark ? AppColors.dark : AppColors.white,
                      selectedColor: Theme.of(context).primaryColor,
                      checkmarkColor: AppColors.light,
                      selected: selected,
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.local_shipping,
                              size: AppSizes.iconSm,
                              color: selected
                                  ? AppColors.light
                                  : AppColors.darkGrey),
                          const SizedBox(width: 6),
                          Text(
                            v.name,
                            style: selected
                                ? Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .apply(color: AppColors.light)
                                : Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .apply(color: AppColors.darkerGrey),
                          ),
                        ],
                      ),
                      onSelected: (_) => ctrl.selectVehicle(v.id),
                    );
                  }).toList(),
                ),

                // 🔵 Capacity bars (Weight / Volume) — restored
                const SizedBox(height: AppSizes.spaceBtwItems),
                if (ctrl.currentVehicle != null) ...[
                  _capacityBar(
                    theme: theme,
                    label:
                        'Weight ${ctrl.usedW.toStringAsFixed(1)} / ${ctrl.effW.toStringAsFixed(1)} kg',
                    value: ctrl.pctW,
                  ),
                  const SizedBox(height: 6),
                  _capacityBar(
                    theme: theme,
                    label:
                        'Volume ${ctrl.usedV.toStringAsFixed(2)} / ${ctrl.effV.toStringAsFixed(2)} m³',
                    value: ctrl.pctV,
                  ),
                  if (ctrl.isOverCapacity) ...[
                    const SizedBox(height: 6),
                    Text(
                      ctrl.overReason,
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: Colors.red),
                    ),
                  ],
                  const SizedBox(height: AppSizes.spaceBtwItems),
                ],

                // ORDERS picker field
                Text('Orders', style: theme.textTheme.labelLarge),
                const SizedBox(height: AppSizes.spaceBtwItems),
                GestureDetector(
                  onTap: pickOrders,
                  child: AbsorbPointer(
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        hintStyle: Theme.of(context).textTheme.labelMedium,
                        hintText: chosenNames.isEmpty
                            ? 'Tap to choose orders'
                            : chosenNames.join(', '),
                        prefixIcon:
                            const Icon(Icons.receipt_long_outlined),
                        suffixIcon: const Icon(Icons.expand_more),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppSizes.spaceBtwItems),
                Text(
                  'Total COD: \$${ctrl.totalCod.toStringAsFixed(2)}',
                  style: theme.textTheme.labelLarge!.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: AppSizes.spaceBtwSections / 2),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: ctrl.canSave
                        ? () {
                            result = TripSelection(
                              vehicleId: ctrl.selectedVehicleId.value!,
                              orderIds: ctrl.selectedOrderIds.toList(),
                            );
                            Get.back();
                          }
                        : null,
                    child: const Text('Save Trip'),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
      isScrollControlled: true,
    );

    Get.delete<TripSheetController>(tag: tag, force: true);
    return result;
  }

  static Widget _capacityBar({
    required ThemeData theme,
    required String label,
    required double value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.bodySmall),
        const SizedBox(height: AppSizes.spaceBtwItems / 2),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: value.clamp(0, 1),
            minHeight: 6,
            backgroundColor: Colors.grey[300],
            valueColor:
                const AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
      ],
    );
  }
}
