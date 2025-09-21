import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/device_helpers.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
  });
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDeviceHelpers.getScreenWidth(context),
      child: ElevatedButton(onPressed: onPressed, child: child),
    );
  }
}
