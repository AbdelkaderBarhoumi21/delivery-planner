// lib/features/shop/models/order_validation_model.dart
class OrderValidationResult {
  final String orderId;
  final double cod;
  final String sku;
  final String serial;
  final int quantity;

  OrderValidationResult({
    required this.orderId,
    required this.cod,
    required this.sku,
    required this.serial,
    required this.quantity,
  });
}
