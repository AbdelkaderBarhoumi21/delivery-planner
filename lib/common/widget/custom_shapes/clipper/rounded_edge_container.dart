import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/clipper/custom_rounded_cliper.dart';

class AppRoundedEgdesContainer extends StatelessWidget {
  const AppRoundedEgdesContainer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: AppCustomRoundedEgdes(), child: child);
  }
}
