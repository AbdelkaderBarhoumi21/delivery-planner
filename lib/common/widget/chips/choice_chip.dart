import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/circular_container.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';

class AppChoiceChip extends StatelessWidget {
  const AppChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    required this.onSelected,
  });

  final String text;
  final bool selected;
  final Function(bool?) onSelected;
  @override
  Widget build(BuildContext context) {
    bool isColor = AppHelperFunctions.getColor(text) != null;
    return ChoiceChip(
      label: isColor ? SizedBox() : Text(text),
      selected: selected,
      onSelected: onSelected,
      labelStyle: TextStyle(color: selected ? AppColors.white : null),
      shape: isColor ? CircleBorder() : null,
      labelPadding: isColor ? EdgeInsets.zero : null,
      padding: isColor ? EdgeInsets.zero : null,
      backgroundColor: isColor ? AppHelperFunctions.getColor(text) : null,
      avatar: isColor
          ? AppCircularContainer(
              width: 50,
              height: 50,
              backgroundColor: AppHelperFunctions.getColor(text)!,
            )
          : null,
    );
  }
}
