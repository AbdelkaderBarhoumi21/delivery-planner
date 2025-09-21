import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/rounded_container.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/controllers/order/orderdetails_controller.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppOrderMap extends StatelessWidget {
  const AppOrderMap({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    final controller = OrdersdetailsController.instance;
    return AppRoundedContainer(
      width: double.infinity,
      height: 300,
      padding: EdgeInsets.all(1),
      showBorder: true,
      backgroundColor: dark ? AppColors.dark : AppColors.light,
      child: GoogleMap(
        mapType: MapType.normal,
        markers: controller.markers.toSet(),
        initialCameraPosition: controller.cameraPosition, // non-null maintenant
        onMapCreated: (GoogleMapController gmController) {
          // évite l’exception si recréé
          if (!controller.completerController.isCompleted) {
            controller.completerController.complete(gmController);
          }
        },
      ),
    );
  }
}
