import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/device_helpers.dart';
import 'package:lottie/lottie.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.animation,
    required this.title,
    required this.subTitle,
  });
  final String animation;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppDeviceHelpers.getAppBarHeight()),
      child: Column(
        children: [
          Lottie.asset(animation),
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          Text(subTitle, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
