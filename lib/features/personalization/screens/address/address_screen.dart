import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/styles/padding.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/appbar/appbar.dart';
import 'package:flutter_ecommerce_app_v2/features/personalization/screens/address/add_address_screen.dart';
import 'package:flutter_ecommerce_app_v2/features/personalization/screens/address/widgets/single_address.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Appbar
      appBar: UAppBar(
        title: Text(
          'Addresses',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),

      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.screenPadding,
          child: Column(
            children: [
              AppSingleAddress(isSelected: true),
              SizedBox(height: AppSizes.spaceBtwItems),
              AppSingleAddress(isSelected: false),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddNewAddressScree()),
        backgroundColor: AppColors.primary,
        child: Icon(Iconsax.add, color: AppColors.white),
      ),
    );
  }
}
