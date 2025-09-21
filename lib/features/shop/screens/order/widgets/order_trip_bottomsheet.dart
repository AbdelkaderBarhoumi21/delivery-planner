import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/controllers/order/order_map_controller.dart'
    show OrdersTripMapController;
import 'package:flutter_ecommerce_app_v2/test_data.dart';
import 'package:get/get.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/controllers/order/trip_controller.dart';
import 'package:flutter_ecommerce_app_v2/common/styles/padding.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/button/elevated_button.dart';

import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderTripBottomsheet {
  static Future<void> pickOrders(BuildContext context) async {
    final controller = Get.put(
      TripSheetController(vehicles: TestData.vehicles, orders: TestData.orders),
      tag: 'trip_screen_controller',
    );
    final theme = Theme.of(context);
    final dark = AppHelperFunctions.isDarkMode(context);
    final tmp = Set<String>.from(controller.selectedOrderIds);

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
                  // Header
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
                  // Actions
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          tmp
                            ..clear()
                            ..addAll(controller.orders.map((o) => o.id));
                          setSheet(() {});
                        },
                        icon: Icon(Icons.select_all, color: AppColors.primary),
                        label: Text(
                          'Select all',
                          style: theme.textTheme.labelLarge,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          tmp.clear();
                          setSheet(() {});
                        },
                        icon: Icon(Icons.clear_all, color: AppColors.primary),
                        label: Text('Clear', style: theme.textTheme.labelLarge),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: controller.orders.map((o) {
                      final checked = tmp.contains(o.id);
                      return FilterChip(
                        backgroundColor: dark
                            ? AppColors.dark
                            : AppColors.light,
                        selectedColor: Theme.of(context).primaryColor,
                        checkmarkColor: AppColors.light,
                        label: Text(
                          o.displayName,
                          style: (checked
                              ? theme.textTheme.labelSmall?.apply(
                                  color: AppColors.light,
                                )
                              : theme.textTheme.labelMedium?.apply(
                                  color: AppColors.darkerGrey,
                                ))!,
                        ),
                        selected: checked,
                        onSelected: (val) {
                          // Si tu veux empêcher de dépasser la capacité, remplace par controller.tryToggleOrder(...)
                          val ? tmp.add(o.id) : tmp.remove(o.id);
                          setSheet(() {});
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  AppElevatedButton(
                    onPressed: () => Get.back(result: true),
                    child: const Text('Confirm'),
                  ),
                  const SizedBox(height: 12),
                ],
              );
            },
          ),
        ),
      ),
      isScrollControlled: true,
    );

    if (ok == true) {
      // Appliquer la sélection
      controller.selectedOrderIds
        ..clear()
        ..addAll(tmp);

      // Mettre à jour la carte: Order1 / Order2 (mock coords ou vraies coords si dispo)
      final selected = controller.selectedOrderIds.toList();
      // Exemple: 2 points fixes pour la démo
      if (selected.isNotEmpty) {
        final p1 = const LatLng(35.8469, 10.6075); // mock order 1
        OrdersTripMapController.instance.setOrder1(p1);
      } else {
        OrdersTripMapController.instance.setOrder1(null);
      }
      if (selected.length >= 2) {
        final p2 = const LatLng(35.8580, 10.6250); // mock order 2
        OrdersTripMapController.instance.setOrder2(p2);
      } else {
        OrdersTripMapController.instance.setOrder2(null);
      }
    }
  }
}
