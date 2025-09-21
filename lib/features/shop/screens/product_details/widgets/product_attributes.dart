import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/chips/choice_chip.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/custom_shapes/rounded_container.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/texts/product_price.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/texts/product_title_text.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/texts/section_heading.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';

class AppProductAttributes extends StatelessWidget {
  const AppProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        // selected attributes pricing description
        AppRoundedContainer(
          padding: EdgeInsets.all(AppSizes.md),
          backgroundColor: dark ? AppColors.darkerGrey : AppColors.grey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //title price stock
              Row(
                children: [
                  //variation heading
                  AppSectionHeading(
                    title: 'Variation',
                    showActionsButtons: false,
                  ),
                  SizedBox(width: AppSizes.spaceBtwItems),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //price sale price actual price
                      Row(
                        children: [
                          //price heading
                          AppProductTitleText(
                            title: 'Price : ',
                            smallSize: true,
                          ),
                          SizedBox(width: AppSizes.spaceBtwItems),
                          //old price
                          Text(
                            '\$250',
                            style: Theme.of(context).textTheme.titleSmall!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                          SizedBox(width: AppSizes.spaceBtwItems / 1.5),
                          //actual price
                          AppProductPriceText(price: '200'),
                        ],
                      ),
                      //stock status
                      Row(
                        children: [
                          AppProductTitleText(
                            title: 'Stock : ',
                            smallSize: true,
                          ),
                          SizedBox(width: AppSizes.spaceBtwItems),
                          Text(
                            'In Stock',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(width: AppSizes.spaceBtwItems),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: AppSizes.spaceBtwItems),
              //attributes description
              AppProductTitleText(
                title: 'This is a product of iPhone 11 with 512 GB',
                smallSize: true,
                maxLines: 1,
              ),
            ],
          ),
        ),
        SizedBox(height: AppSizes.spaceBtwItems),
        //attributes - color
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSectionHeading(title: 'Colors', showActionsButtons: false),
            SizedBox(height: AppSizes.spaceBtwItems / 2),
            Wrap(
              spacing: AppSizes.sm,
              children: [
                AppChoiceChip(
                  text: 'Red',
                  onSelected: (value) {},
                  selected: true,
                ),
                AppChoiceChip(
                  text: 'Blue',
                  onSelected: (value) {},
                  selected: false,
                ),
                AppChoiceChip(
                  text: 'Orange',
                  onSelected: (value) {},
                  selected: false,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: AppSizes.spaceBtwItems / 1.5),
        //attributes - storage
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSectionHeading(title: 'Sizes', showActionsButtons: false),
            SizedBox(height: AppSizes.spaceBtwItems / 2),
            Wrap(
              spacing: AppSizes.sm,
              children: [
                AppChoiceChip(
                  text: 'Small',
                  onSelected: (value) {},
                  selected: true,
                ),
                AppChoiceChip(
                  text: 'Medium',
                  onSelected: (value) {},
                  selected: false,
                ),
                AppChoiceChip(
                  text: 'Large',
                  onSelected: (value) {},
                  selected: false,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
