import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/appbar/appbar.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/order/stepper.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/order/widgets/order_timeline.dart';

class OrdersDoneScreen extends StatefulWidget {
  const OrdersDoneScreen({super.key});
  @override
  State<OrdersDoneScreen> createState() => _OrdersDoneScreenState();
}

class _OrdersDoneScreenState extends State<OrdersDoneScreen> {
  OrderState state = OrderState.activated; // change à volonté

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          'Orders Summary',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Timeline
            Padding(padding: const EdgeInsets.all(16), child: CustomStepper()),
          ],
        ),
      ),
    );
  }
}
