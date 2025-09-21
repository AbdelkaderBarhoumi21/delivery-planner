import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/appbar/tabBar.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/brand/brand_card.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/texts/section_heading.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/brands/all_brand_screen.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/store/widgets/category_tab.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/store/widgets/primary_header_store.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 340,
                pinned: true,
                floating: false,
                // snap: true,
                flexibleSpace: SingleChildScrollView(
                  child: Column(
                    children: [
                      //primary header
                      AppStorePrimaryHeader(),
                      SizedBox(height: AppSizes.spaceBtwItems),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.defaultSpace,
                        ),
                        child: Column(
                          children: [
                            //brand herading
                            AppSectionHeading(
                              title: 'Brands',
                              onPressed: () => Get.to(() => AllBrandScreen()),
                            ),
                            //Brand Card
                            SizedBox(
                              height: AppSizes.brandCardHeight,
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    SizedBox(width: AppSizes.spaceBtwItems / 2),
                                shrinkWrap: true,
                                itemCount: 10,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => SizedBox(
                                  width: AppSizes.brandCardWidth,
                                  child: AppBrandCard(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //TabBar categories
                bottom: AppTabBar(
                  tabs: [
                    Tab(child: Text('Sports')),
                    Tab(child: Text('Sports')),
                    Tab(child: Text('Sports')),
                    Tab(child: Text('Sports')),
                    Tab(child: Text('Sports')),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              AppCategoryTab(),
              AppCategoryTab(),
              AppCategoryTab(),
              AppCategoryTab(),
              AppCategoryTab(),
            ],
          ),
        ),
      ),
    );
  }
}
