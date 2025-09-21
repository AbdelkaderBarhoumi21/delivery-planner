import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/image_text/vertical_image_text.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/sub_category/sub_category_screen.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/image.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/texts.dart';
import 'package:get/get.dart';

class AppHomeCategories extends StatelessWidget {
  const AppHomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: AppSizes.spaceBtwSections),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Home catgeoires
          Text(
            AppTexts.popularCategories,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.apply(color: AppColors.white),
          ),
          SizedBox(height: AppSizes.spaceBtwItems),
          //categoires listview
          SizedBox(
            height: 80,
            child: ListView.separated(
              separatorBuilder: (context, index) =>
                  SizedBox(width: AppSizes.spaceBtwItems),
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return AppVerticalImageText(
                  title: 'Sport Categories',
                  image: AppImages.sportsIcon,
                  textColor: AppColors.white,
                  onTap: () => Get.to(() => SubCategoryScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
