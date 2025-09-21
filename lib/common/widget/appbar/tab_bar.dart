import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/device_helpers.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';
class AppTabBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTabBar({super.key, required this.tabs});
  final List<Widget> tabs;
  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? AppColors.black : AppColors.white,
      child: TabBar(
        isScrollable: true,
        labelColor: dark ? AppColors.white : AppColors.primary,
        unselectedLabelColor: AppColors.darkGrey,
        indicatorColor: AppColors.primary,

        tabs: tabs,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppDeviceHelpers.getAppBarHeight());
}
