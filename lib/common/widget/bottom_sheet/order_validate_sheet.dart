import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/models/order_validation_model.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';

class OrderValidateSheet {
  /// Returns an OrderValidationResult, or null if cancelled.
  static Future<OrderValidationResult?> show(
    BuildContext context,
    List<String> remaining,
  ) async {
    if (remaining.isEmpty) return null;

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final codCtrl = TextEditingController();
    final skuCtrl = TextEditingController();
    final serialCtrl = TextEditingController();
    final qtyCtrl = TextEditingController(text: '1');

    String selectedOrder = remaining.first;

    try {
      final res = await Get.bottomSheet<OrderValidationResult>(
        Material(
          color: theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Validate an order',
                          style: theme.textTheme.titleMedium,
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => Get.back(), // cancel -> null
                          icon: Icon(
                            Icons.close,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Order picker (value must be inside items)
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: selectedOrder,
                      items: remaining
                          .map(
                            (id) =>
                                DropdownMenuItem(value: id, child: Text(id)),
                          )
                          .toList(),
                      decoration: const InputDecoration(
                        labelText: 'Choose order to validate',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.assignment_turned_in_outlined),
                      ),
                      onChanged: (v) {
                        if (v != null) selectedOrder = v;
                      },
                    ),

                    const SizedBox(height: AppSizes.spaceBtwInputFields),

                    TextFormField(
                      controller: codCtrl,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'COD',
                        prefixIcon: Icon(Icons.attach_money_rounded),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwInputFields),

                    TextFormField(
                      controller: skuCtrl,
                      decoration: const InputDecoration(
                        labelText: 'SKU',
                        prefixIcon: Icon(Icons.inventory_2_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwInputFields),

                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: serialCtrl,
                            decoration: const InputDecoration(
                              labelText: 'Serial number',
                              prefixIcon: Icon(Icons.qr_code_2_outlined),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSizes.spaceBtwInputFields),
                        Expanded(
                          child: TextFormField(
                            controller: qtyCtrl,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Quantity',
                              prefixIcon: Icon(Icons.tag_sharp),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          // SAFE parsing — prevents crashes
                          final q =
                              int.tryParse(qtyCtrl.text.trim()) ?? 1; // >= 1
                          final cod =
                              double.tryParse(
                                codCtrl.text.trim().replaceAll(',', '.'),
                              ) ??
                              0.0;

                          final result = OrderValidationResult(
                            orderId: selectedOrder,
                            cod: cod,
                            sku: skuCtrl.text.trim(),
                            serial: serialCtrl.text.trim(),
                            quantity: q < 1 ? 1 : q,
                          );
                          Get.back(result: result);
                        },
                        child: const Text('Mark as delivered'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        isScrollControlled: true,
      );

      return res; // null if cancelled
    } catch (e) {
      print(e);
    }
  }
}
