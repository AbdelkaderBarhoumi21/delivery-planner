class TripSummary {
  final String id;
  final String vehicleName;
  final double usedWeight;
  final double usedVolume;
  final double totalCod;
  final List<String> orderIds;

  TripSummary({
    required this.id,
    required this.vehicleName,
    required this.usedWeight,
    required this.usedVolume,
    required this.totalCod,
    required this.orderIds,
  });
}
