class AssignedVM {
  final String id;
  final String status;         // 'Pending' | 'In-Transit'
  final DateTime shippingDate;
  final String customerName;
  AssignedVM({
    required this.id,
    required this.status,
    required this.shippingDate,
    required this.customerName,
  });
}