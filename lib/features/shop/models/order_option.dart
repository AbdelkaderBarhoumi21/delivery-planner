class OrderOption {
  final String id;
  final String displayName; // e.g. "ORD-001 • Alice"
  final double weight;      // total order weight
  final double volume;      // total order volume
  final double codAmount;   // COD for this order

  const OrderOption({
    required this.id,
    required this.displayName,
    required this.weight,
    required this.volume,
    required this.codAmount,
  });
}