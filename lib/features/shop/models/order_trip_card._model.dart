class TripCardVM {
  final String id;
  final String vehicleName;
  final double usedWeight;
  final double usedVolume;
  final double totalCod;
  final List<String> orderIds; // dérivé des stops
  final bool isActive;         // au moins un stop Pending / InTransit
  final bool isCompleted;      // tous les stops Completed

  TripCardVM({
    required this.id,
    required this.vehicleName,
    required this.usedWeight,
    required this.usedVolume,
    required this.totalCod,
    required this.orderIds,
    required this.isActive,
    required this.isCompleted,
  });
}