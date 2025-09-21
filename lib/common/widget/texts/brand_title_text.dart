import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/enums.dart';

class AppBrandTitleText extends StatelessWidget {
  const AppBrandTitleText({
    super.key,
    required this.title,
    this.brandTextSizes = TextSizes.small,
    this.maxLines = 1,
    this.color,
    this.textAlign = TextAlign.center,
  });
  final String title;
  final Color? color;
  final int maxLines;
  final TextAlign? textAlign;
  final TextSizes brandTextSizes;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: brandTextSizes == TextSizes.small
          ? Theme.of(context).textTheme.labelMedium!.apply(color: color)
          : brandTextSizes == TextSizes.medium
          ? Theme.of(context).textTheme.bodyLarge!.apply(color: color)
          : brandTextSizes == TextSizes.large
          ? Theme.of(context).textTheme.titleLarge!.apply(color: color)
          : Theme.of(context).textTheme.bodyMedium!.apply(color: color),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
    );
  }
}
