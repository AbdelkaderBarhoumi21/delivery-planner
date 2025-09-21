import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/images/circular_images.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/image.dart';

class AppUserProfileLogo extends StatelessWidget {
  const AppUserProfileLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppCircularImage(
      image: AppImages.profileLogo,
      height: 120.0,
      width: 120.0,
      borderWidth: 5.0,
      padding: 0,
    );
  }
}
