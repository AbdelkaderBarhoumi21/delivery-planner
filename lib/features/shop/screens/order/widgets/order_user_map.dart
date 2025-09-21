import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/rounded_container.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/controllers/order/orderdetails_controller.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class AppOrderuserMap extends StatelessWidget {
  const AppOrderuserMap({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    final controller = OrdersdetailsController.instance;

    return AppRoundedContainer(
      width: double.infinity,
      height: 300,
      padding: const EdgeInsets.all(1),
      showBorder: true,
      backgroundColor: dark ? AppColors.dark : AppColors.light,
      child: GoogleMap(
        mapType: MapType.normal,
        markers: controller.markers.toSet(),
        initialCameraPosition: controller.cameraPosition,
        onMapCreated: (GoogleMapController gmController) async {
          if (!controller.completerController.isCompleted) {
            controller.completerController.complete(gmController);
          }
          await Future.delayed(const Duration(milliseconds: 100));
          controller.fitBounds();
        },
      ),
    );
  }
}
