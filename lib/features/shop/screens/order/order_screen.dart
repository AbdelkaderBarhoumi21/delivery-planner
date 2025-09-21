import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/styles/padding.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/appbar/appbar.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/order/widgets/orders_list.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar
      appBar: UAppBar(
        title: Text(
          'My Orders',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      //body
      body: Padding(
        padding: AppPadding.screenPadding,
        child: AppOrdersListItems(),
      ),
    );
  }
}
