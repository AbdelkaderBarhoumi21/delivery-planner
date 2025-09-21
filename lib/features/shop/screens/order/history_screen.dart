import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/styles/padding.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/appbar/appbar.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/icons/circular_icon.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/order/widgets/order_history_card.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/appbar/tabBar.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: UAppBar(
          title: Text(
            'Order History',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            AppCircularIcon(
              backgroundColor: Colors.transparent,
              icon: Iconsax.notification_status,
              onPressed: () {},
            ),
          ],
        ),
        body: Padding(
          padding: AppPadding.screenPadding,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AppTabBar(
                  tabs: [
                    Tab(text: 'Active'),
                    Tab(text: 'Completed'),
                    Tab(text: 'Cancelled'),
                  ],
                ),

                const SizedBox(height: 8),

                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: SizedBox(
                    height: screenH,
                    child: TabBarView(
                      children: [
                        AppOrderHistoryCard(
                          shrinkWrap: true,
                          nonScrollable: true,
                          onTap: () {},
                        ),
                        AppOrderHistoryCard(
                          shrinkWrap: true,
                          nonScrollable: true,
                          onTap: () {},
                        ),
                        AppOrderHistoryCard(
                          shrinkWrap: true,
                          nonScrollable: true,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
