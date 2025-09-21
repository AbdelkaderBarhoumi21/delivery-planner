import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/primary_header_container.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/images/user_profile_logo.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';

class AppProfilePrimaryHeader extends StatelessWidget {
  const AppProfilePrimaryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //total height
        SizedBox(height: AppSizes.profilePrimaryHeaderHeight + 60),
        //header container
        AppPrimaryHeaderContainer(
          child: Container(),
          height: AppSizes.profilePrimaryHeaderHeight,
        ),
        //circular image
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(child: AppUserProfileLogo()),
        ),
      ],
    );
  }
}
