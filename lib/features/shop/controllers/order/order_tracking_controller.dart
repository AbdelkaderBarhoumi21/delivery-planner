// lib/features/shop/controllers/order/order_tracking_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// <-- import the model returned by the sheet
import 'package:flutter_ecommerce_app_v2/features/shop/models/order_validation_model.dart';
// <-- import the sheet itself
import 'package:flutter_ecommerce_app_v2/common/widget/bottom_sheet/order_validate_sheet.dart';

class OrderTrackingController extends GetxController {
  OrderTrackingController({
    required this.tripId,
    required this.orderIds,
  });

  final String tripId;
  final List<String> orderIds;

  /// stepper
  final RxInt currentStep = 0.obs;
  final RxBool isCompleted = false.obs;

  /// which orders are validated
  final RxSet<String> validated = <String>{}.obs;

  /// simple log lines shown under step 1
  final RxList<String> logs = <String>[].obs;

  List<String> get remaining =>
      orderIds.where((id) => !validated.contains(id)).toList();

  bool get allValidated => validated.length == orderIds.length;

  Future<void> onContinue(BuildContext context) async {
    if (currentStep.value == 0) {
      // Accept the trip
      logs.clear();
      currentStep.value = 1;
      return;
    }

    if (currentStep.value == 1) {
      // Ask the user to validate one of the remaining orders
      final OrderValidationResult? picked =
          await OrderValidateSheet.show(context, remaining);

      if (picked != null) {
        // store the order id as validated
        validated.add(picked.orderId);

        // optional: log some details for the UI
        logs.add(
          '• ${picked.orderId} validated '
          '(COD \$${picked.cod.toStringAsFixed(2)}, '
          'SKU ${picked.sku}, '
          'SN ${picked.serial}, '
          'Q=${picked.quantity})',
        );

        // if all orders in this trip are validated -> complete
        if (allValidated) {
          isCompleted.value = true;
          currentStep.value = 2;
        }
      }
      return;
    }

    if (currentStep.value == 2) {
      // Finish: go back to the previous screen (trip list)
      Get.back();
    }
  }

  void onCancel() {
    if (currentStep.value > 0) currentStep.value -= 1;
  }

  void onStepTapped(int index) {
    currentStep.value = index;
  }
}
