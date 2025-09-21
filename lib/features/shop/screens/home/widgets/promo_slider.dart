import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/images/rounded_image.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/controllers/home/home_controller.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/home/widgets/banner_dot_navigation.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';

class AppPromoSlider extends StatelessWidget {
  const AppPromoSlider({required this.banners, super.key});

  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    final controller=HomeController.instance;
    return Column(
      children: [
        //carousel slider
        CarouselSlider(
          items: banners
              .map((banner) => AppRoundedImage(imageUrl: banner))
              .toList(),

          options: CarouselOptions(
            onPageChanged:(index,reason)=>controller.onPageChanged(index),
            viewportFraction: 1.0,
            padEnds: false, // évite le padding au tout début/fin
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            // autoPlay: true,
            // enableInfiniteScroll: true,//ifinity loop no limited to length
          ),
          carouselController: controller.carouselController,
        ),
        SizedBox(height: AppSizes.spaceBtwItems),
        //dot navigation banner
        BannerDotNavigation(),
      ],
    );
  }
}
