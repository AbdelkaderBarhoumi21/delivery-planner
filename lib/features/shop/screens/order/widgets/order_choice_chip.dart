// lib/features/shop/screens/order/order_trip_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/controllers/order/trip_controller.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppVehicleChoiceChip extends StatelessWidget {
  const AppVehicleChoiceChip({
    super.key,
    required this.ctrl,
    required this.theme,
    required this.kDepot,
    this.onTap,
  });

  final TripSheetController ctrl;
  final ThemeData theme;
  final LatLng kDepot;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    // Dépôt (exemple Sousse — adapte si tu veux)
    LatLng kDepot = LatLng(35.8369, 10.5925);
    return GestureDetector(
      onTap: onTap,
      child: Wrap(
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
                      ? theme.textTheme.labelMedium!.apply(
                          color: AppColors.light,
                        )
                      : theme.textTheme.labelMedium!.apply(
                          color: AppColors.darkerGrey,
                        ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
