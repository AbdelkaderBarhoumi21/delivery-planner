class HistoryItemVM {
  final String id;
  final String status; // "Pending", "In-Transit", etc.
  final DateTime shippingDate;
  final String customerName;
  HistoryItemVM({
    required this.id,
    required this.status,
    required this.shippingDate,
    required this.customerName,
  });
}