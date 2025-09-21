import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/rounded_container.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/controllers/order/order_map_controller.dart';

class AppOrderTripMap extends StatelessWidget {
  const AppOrderTripMap({super.key, required this.controller});

  final OrdersTripMapController controller;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    final c = controller;

    return AppRoundedContainer(
      width: double.infinity,
      height: 300,
      padding: const EdgeInsets.all(1),
      showBorder: true,
      backgroundColor: dark ? AppColors.dark : AppColors.light,
      child: Obx(() {
        final markers = c.markersRx.toSet();
        final polylines = c.polylinesRx.toSet();

        return GoogleMap(
          mapType: MapType.normal,
          markers: markers,
          polylines: polylines,
          initialCameraPosition: c.cameraPosition,
          onMapCreated: (gm) {
            if (!c.completerController.isCompleted) {
              c.completerController.complete(gm);
            }
          },
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
        );
      }),
    );
  }
}
