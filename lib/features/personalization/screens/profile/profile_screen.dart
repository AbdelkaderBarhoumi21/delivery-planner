import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/button/outline_button.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/texts/section_heading.dart';
import 'package:flutter_ecommerce_app_v2/features/personalization/screens/address/address_screen.dart';
import 'package:flutter_ecommerce_app_v2/features/personalization/screens/profile/widgets/profile_primary_header.dart';
import 'package:flutter_ecommerce_app_v2/features/personalization/screens/profile/widgets/settings_menu_profile_tile.dart';
import 'package:flutter_ecommerce_app_v2/features/personalization/screens/profile/widgets/user_profile_tile.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/order/order_screen.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //primary header profile
            AppProfilePrimaryHeader(),
            Padding(
              padding: const EdgeInsets.all(AppSizes.defaultSpace),
              child: Column(
                children: [
                  //user profile details edit
                  AppUserProfileTile(),
                  SizedBox(height: AppSizes.spaceBtwItems),
                  //settings heading
                  AppSectionHeading(
                    title: "Account Settings",
                    showActionsButtons: false,
                  ),
                  //settings menu
                  AppSettingsProfileMenuTile(
                    icon: Iconsax.safe_home,
                    title: "My Addresses",
                    subTitle: "Set shopping delivbery addresses",
                    onTap: () => Get.to(() => UserAddressScreen()),
                  ),
                  AppSettingsProfileMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: "My Cart",
                    subTitle: "Add ,remove products and move to checkout",
                    onTap: () {},
                  ),
                  AppSettingsProfileMenuTile(
                    icon: Iconsax.bag_tick,
                    title: "My Orders",
                    subTitle: "In-progress and Completed Orders",
                    onTap: () => Get.to(() => OrderScreen()),
                  ),
                  SizedBox(height: AppSizes.spaceBtwSections),
                  //Logout button
                  AppOutlineButton(onPressed: () {}, child: Text("Logout")),
                  SizedBox(height: AppSizes.spaceBtwSections),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
