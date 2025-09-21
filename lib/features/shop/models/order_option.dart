class OrderOption {
  final String id;
  final String displayName; // ex: ORD-001 • Alice
  final double weight;      // poids total de la commande
  final double volume;      // volume total de la commande

  const OrderOption({
    required this.id,
    required this.displayName,
    required this.weight,
    required this.volume,
  });
}