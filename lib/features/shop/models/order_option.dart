class OrderOption {
  final String id;
  final String displayName; // e.g. "ORD-001"
  final double weight;
  final double volume;
  final double codAmount;

  const OrderOption({
    required this.id,
    required this.displayName,
    required this.weight,
    required this.volume,
    required this.codAmount,
  });

  factory OrderOption.fromHive(Map<String, dynamic> m) {
    return OrderOption(
      id: m['id'] as String,
      displayName: m['id'] as String,
      weight: (m['weight'] as num).toDouble(),
      volume: (m['volume'] as num).toDouble(),
      codAmount: (m['codAmount'] as num).toDouble(),
    );
  }
}
