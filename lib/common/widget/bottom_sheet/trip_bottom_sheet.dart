import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/controllers/order/trip_controller.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/models/trip_selection_model.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:flutter_ecommerce_app_v2/common/styles/padding.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/button/elevated_button.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';

// Tes modèles “options” (simples DTO) :
import 'package:flutter_ecommerce_app_v2/features/shop/models/vehicle_model.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/models/order_option.dart';

/// Résultat renvoyé par la sheet

/// Controller GetX pour gérer l’état de la sheet

/// Bottom-sheet principale (avec sous-sheet Orders)
class TripBottomSheet {
  static Future<TripSelection?> show(
    BuildContext context, {
    required List<VehicleOption> vehicles,
    required List<OrderOption> orders,
  }) async {
    final theme = Theme.of(context);
    final dark = AppHelperFunctions.isDarkMode(context);

    // on tag le controller pour bien le nettoyer à la fin
    final tag = 'trip_sheet_${UniqueKey()}';
    final ctrl = Get.put(
      TripSheetController(vehicles: vehicles, orders: orders),
      tag: tag,
    );

    TripSelection? result;

    // ---------- Sous-sheet Orders (multi sélection, UI comme tu l'as montré) ----------
    Future<void> _pickOrders() async {
      final tmp = Set<String>.from(ctrl.selectedOrderIds);

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
                final selectedCount = tmp.length;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // header
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Select Orders ($selectedCount selected)',
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Get.back(result: false),
                          icon: Icon(
                            Icons.close,
                            color: dark ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),

                    // actions rapides
                    Row(
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            tmp
                              ..clear()
                              ..addAll(orders.map((o) => o.id));
                            setSheet(() {});
                          },
                          icon: Icon(
                            Icons.select_all,
                            color: AppColors.primary,
                          ),
                          label: Text(
                            'Select all',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            tmp.clear();
                            setSheet(() {});
                          },
                          icon: const Icon(
                            Icons.clear_all,
                            color: AppColors.primary,
                          ),
                          label: Text(
                            'Clear',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSizes.spaceBtwItems / 4),
                    // chips
                    Wrap(
                      spacing: AppSizes.spaceBtwItems / 2,
                      runSpacing: AppSizes.spaceBtwItems / 2,
                      children: orders.map((o) {
                        final checked = tmp.contains(o.id);
                        final label = '${o.displayName}';
                        return FilterChip(
                          backgroundColor: dark
                              ? AppColors.dark
                              : AppColors.light,
                          selectedColor: Theme.of(context).primaryColor,
                          checkmarkColor: AppColors.light,
                          label: Text(
                            label,
                            style: checked
                                ? Theme.of(context).textTheme.labelSmall!.apply(
                                    color: AppColors.light,
                                  )
                                : Theme.of(context).textTheme.labelMedium!
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
                      child: const Text('Confirm  (COD :\$250.00)'),
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
        ctrl.selectedOrderIds
          ..clear()
          ..addAll(tmp);
      }
    }

    // ---------------- Sheet principale ----------------
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
                // header
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Plan a Trip',
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.close,
                        color: dark ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwItems / 2),

                // 1) véhicule
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text('Vehicle', style: theme.textTheme.labelLarge),
                    const SizedBox(height: AppSizes.spaceBtwItems),
                    Wrap(
                      spacing: AppSizes.spaceBtwItems / 2,
                      runSpacing: AppSizes.spaceBtwItems / 2,
                      children: ctrl.vehicles.map((v) {
                        final selected = ctrl.selectedVehicleId.value == v.id;
                        return ChoiceChip(
                          backgroundColor: dark
                              ? AppColors.dark
                              : AppColors.white,
                          selectedColor: Theme.of(context).primaryColor,
                          checkmarkColor: AppColors.light,
                          selected: selected,
                          // labelPadding: const EdgeInsets.symmetric(
                          //   horizontal: 10,
                          // ),
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              selected
                                  ? Icon(
                                      Icons.local_shipping,
                                      size: AppSizes.iconSm,
                                      color: AppColors.light,
                                    )
                                  : Icon(
                                      Icons.local_shipping,
                                      size: AppSizes.iconSm,
                                      color: AppColors.darkGrey,
                                    ),
                              const SizedBox(width: 6),
                              Text(
                                v.name,
                                style: selected
                                    ? Theme.of(context).textTheme.labelMedium!
                                          .apply(color: AppColors.light)
                                    : Theme.of(context).textTheme.labelMedium!
                                          .apply(color: AppColors.darkerGrey),
                              ),
                            ],
                          ),
                          onSelected: (_) => ctrl.selectVehicle(v.id),
                        );
                      }).toList(),
                    ),
                  ],
                ),

                const SizedBox(height: AppSizes.spaceBtwItems),
                if (ctrl.currentVehicle != null) ...[
                  _capacityBar(
                    theme: theme,
                    label:
                        'Poids ${ctrl.usedW.toStringAsFixed(1)} / ${ctrl.effW.toStringAsFixed(1)} kg',
                    value: ctrl.pctW,
                  ),
                  const SizedBox(height: 6),
                  _capacityBar(
                    theme: theme,
                    label:
                        'Volume ${ctrl.usedV.toStringAsFixed(2)} / ${ctrl.effV.toStringAsFixed(2)} m³',
                    value: ctrl.pctV,
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems),
                ],

                // 2) orders (ouvre le sous-sheet)
                Text('Orders', style: theme.textTheme.labelLarge),
                const SizedBox(height: AppSizes.spaceBtwItems),
                GestureDetector(
                  onTap: _pickOrders,
                  child: AbsorbPointer(
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        hintStyle: Theme.of(context).textTheme.labelMedium,
                        hintText: chosenNames.isEmpty
                            ? 'Tap to choose orders'
                            : chosenNames.join(', '),
                        prefixIcon: const Icon(Icons.receipt_long_outlined),
                        suffixIcon: const Icon(Icons.expand_more),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
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

    // Nettoie le controller
    Get.delete<TripSheetController>(tag: tag, force: true);
    return result;
  }

  // jauge simple
  static Widget _capacityBar({
    required ThemeData theme,
    required String label,
    required double value, // 0..1
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
            backgroundColor: Colors.grey[300], // couleur fond
            valueColor: AlwaysStoppedAnimation<Color>(
              AppColors.primary, // 👈 couleur qui dépend de toi
            ),
          ),
        ),
      ],
    );
  }
}
