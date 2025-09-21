// lib/features/shop/screens/order/orders_tracking_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/appbar/appbar.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/controllers/order/order_tracking_controller.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/models/order_trip_track_model.dart';

class OrdersTrackingScreen extends StatelessWidget {
  const OrdersTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Safe extraction
    final dynamic raw = Get.arguments;
    final TripTrackArgs args = switch (raw) {
      TripTrackArgs a => a,
      Map m when m['tripId'] is String && m['orderIds'] is List<String> =>
        TripTrackArgs(
          tripId: m['tripId'] as String,
          orderIds: (m['orderIds'] as List).cast<String>(),
        ),
      _ => const TripTrackArgs(tripId: 'unknown', orderIds: []),
    };

    final c = Get.put(
      OrderTrackingController(tripId: args.tripId, orderIds: args.orderIds),
      tag: 'tracking_${args.tripId}',
    );

    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          'Orders Tracking',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          final step = c.currentStep.value;
          final done = c.isCompleted.value;

          return Stepper(
            elevation: 0,
            type: StepperType.vertical,
            currentStep: step,
            onStepContinue: () => c.onContinue(context),
            onStepCancel: c.onCancel,
            onStepTapped: c.onStepTapped,
            controlsBuilder: (ctx, details) {
              final label = switch (step) {
                0 => 'Accept',
                1 => 'Validate',
                _ => 'Next Trip',
              };
              return Row(
                children: [
                  ElevatedButton(
                    onPressed: details.onStepContinue,
                    child: Text(label),
                  ),
                  if (step > 0) const SizedBox(width: 12),
                  if (step > 0)
                    OutlinedButton(
                      onPressed: details.onStepCancel,
                      child: const Text('Back'),
                    ),
                ],
              );
            },
            steps: [
              Step(
                title: const Text('Order Process'),
                subtitle: const Text('Pending'),
                content: const Text('Confirm you’re taking this trip.'),
                isActive: step >= 0,
                state: StepState.complete,
                stepStyle: StepStyle(
                  color: AppColors.primary,
                  connectorColor: AppColors.primary,
                  connectorThickness: 1,
                ),
              ),
              Step(
                title: const Text('Order Process'),
                subtitle: const Text('In-Transit'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Validate delivered orders one by one.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: AppSizes.spaceBtwItems),
                    ...c.logs.map(
                      (line) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text(line),
                      ),
                    ),
                    if (c.remaining.isNotEmpty)
                      Text(
                        'Remaining: ${c.remaining.join(', ')}',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                  ],
                ),
                isActive: step >= 1,
                state: StepState.complete,
                stepStyle: StepStyle(
                  color: AppColors.primary,
                  connectorColor: AppColors.primary,
                  connectorThickness: 1,
                ),
              ),
              Step(
                title: const Text('Order Process'),
                subtitle: done ? const Text('Completed') : const Text('Error'),
                content: Text(
                  done
                      ? 'All orders delivered. You can go back and plan the next trip.'
                      : 'Some orders are still missing.',
                ),
                isActive: step >= 2,
                state: done ? StepState.complete : StepState.error,
                stepStyle: StepStyle(
                  color: AppColors.primary,
                  connectorColor: AppColors.primary,
                  connectorThickness: 1,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
