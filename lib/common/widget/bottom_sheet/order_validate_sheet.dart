import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_ecommerce_app_v2/servies/hive_services.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/models/order_validation_model.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/colors.dart';
import 'package:flutter_ecommerce_app_v2/utils/constants/sizes.dart';

class OrderValidateSheet {
  /// Returns an OrderValidationResult (or null if cancelled).
  /// Shows only the fields required by the selected order:
  /// - Always: COD, Quantity
  /// - Additionally: Serial numbers if the order contains a serial-tracked item
  static Future<OrderValidationResult?> show(
    BuildContext context,
    List<String> remaining,
  ) async {
    if (remaining.isEmpty) return null;

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Controllers
    final codCtrl = TextEditingController();
    final qtyCtrl = TextEditingController(text: '0');
    final serialsCtrl = TextEditingController();

    // Local state
    String selectedOrderId = remaining.first;
    bool requireSerials = false;
    int defaultQty = 0;

    // Helpers -------------------------------------------------------------
    List<Map<String, dynamic>> _itemsOf(Map<String, dynamic> order) =>
        (order['items'] as List)
            .map((e) => Map<String, dynamic>.from(e as Map))
            .toList();

    bool _anySerialTracked(List<Map<String, dynamic>> items) =>
        items.any((i) => (i['serialTracked'] as bool?) == true);

    int _singleItemQtyOrZero(List<Map<String, dynamic>> items) {
      if (items.length == 1) {
        return (items.first['quantity'] as num).toInt();
      }
      return 0; // multi-SKU orders: let controller enforce per-SKU rules
    }

    void _loadForOrder(String orderId) {
      final order = HiveService.orderRawById(orderId);
      if (order == null) {
        requireSerials = false;
        defaultQty = 0;
        qtyCtrl.text = '0';
        serialsCtrl.clear();
        return;
      }
      final items = _itemsOf(order);
      requireSerials = _anySerialTracked(items);
      defaultQty = _singleItemQtyOrZero(items);
      qtyCtrl.text = defaultQty.toString();
      if (!requireSerials) serialsCtrl.clear();
    }

    // Init for the first order
    _loadForOrder(selectedOrderId);

    try {
      final res = await Get.bottomSheet<OrderValidationResult>(
        Material(
          color: theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: SafeArea(
            top: false,
            child: StatefulBuilder(
              builder: (ctx, setState) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          children: [
                            Text(
                              'Validate an order',
                              style: theme.textTheme.titleMedium,
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () => Get.back(),
                              icon: Icon(
                                Icons.close,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Order picker (remaining only)
                        DropdownButtonFormField<String>(
                          isExpanded: true,
                          value: selectedOrderId,
                          items: remaining
                              .map(
                                (id) => DropdownMenuItem(
                                  value: id,
                                  child: Text(id),
                                ),
                              )
                              .toList(),
                          decoration: const InputDecoration(
                            labelText: 'Choose order to validate',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.assignment_turned_in_outlined,
                            ),
                          ),
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() {
                              selectedOrderId = v;
                              _loadForOrder(selectedOrderId);
                            });
                          },
                        ),

                        const SizedBox(height: AppSizes.spaceBtwInputFields),

                        // COD (always visible)
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

                        // Serial (only when required for this order) + Quantity
                        Row(
                          children: [
                            if (requireSerials)
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  controller: serialsCtrl,
                                  decoration: const InputDecoration(
                                    labelText: 'Serial numbers',
                                    hintText: 'A1, A2',
                                    prefixIcon: Icon(Icons.qr_code_2_outlined),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            if (requireSerials)
                              const SizedBox(
                                width: AppSizes.spaceBtwInputFields,
                              ),
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                controller: qtyCtrl,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Quantity',
                                  prefixIcon: const Icon(Icons.tag_sharp),
                                  border: const OutlineInputBorder(),
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
                              final q =
                                  int.tryParse(
                                    qtyCtrl.text.trim().replaceAll('−', '-'),
                                  ) ??
                                  0;
                              final cod =
                                  double.tryParse(
                                    codCtrl.text.trim().replaceAll(',', '.'),
                                  ) ??
                                  0.0;

                              // SKU is intentionally omitted; controller will auto-pick it
                              // when the order has a single item.
                              Get.back(
                                result: OrderValidationResult(
                                  orderId: selectedOrderId,
                                  cod: cod,
                                  sku:
                                      '', // let controller resolve when single-SKU
                                  serial: serialsCtrl.text.trim(),
                                  quantity: q,
                                ),
                              );
                            },
                            child: const Text('Mark as delivered'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        isScrollControlled: true,
      );

      return res; // null if cancelled
    } catch (e) {
      debugPrint('OrderValidateSheet error: $e');
      return null;
    }
  }
}
