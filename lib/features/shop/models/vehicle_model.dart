/// --- Données d'entrée minimales ---
class VehicleOption {
  final String id;
  final String name;
  final double capacityWeight; // kg
  final double capacityVolume; // m3
  final double fillRate;       // 0..1

  const VehicleOption({
    required this.id,
    required this.name,
    required this.capacityWeight,
    required this.capacityVolume,
    required this.fillRate,
  });
}