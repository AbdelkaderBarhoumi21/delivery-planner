// lib/features/shop/models/trip_model.dart
enum StopStatus { pending, inTransit, completed, failed }

class TripStop {
  final String orderId;
  final StopStatus status;
  final double codCollected;
  final Map<String, int> deliveredBySku;
  final List<String> serials;

  TripStop({
    required this.orderId,
    this.status = StopStatus.pending,
    this.codCollected = 0,
    Map<String, int>? deliveredBySku,
    List<String>? serials,
  })  : deliveredBySku = deliveredBySku ?? const {},
        serials = serials ?? const [];

  TripStop copyWith({
    StopStatus? status,
    double? codCollected,
    Map<String, int>? deliveredBySku,
    List<String>? serials,
  }) => TripStop(
        orderId: orderId,
        status: status ?? this.status,
        codCollected: codCollected ?? this.codCollected,
        deliveredBySku: deliveredBySku ?? this.deliveredBySku,
        serials: serials ?? this.serials,
      );

  Map<String, dynamic> toMap() => {
        'orderId': orderId,
        'status': status.name,
        'codCollected': codCollected,
        'deliveredBySku': deliveredBySku,
        'serials': serials,
      };

  factory TripStop.fromMap(Map<String, dynamic> m) => TripStop(
        orderId: m['orderId'] as String,
        status: StopStatus.values.firstWhere(
          (e) => e.name == (m['status'] as String? ?? 'pending'),
          orElse: () => StopStatus.pending,
        ),
        codCollected: (m['codCollected'] as num?)?.toDouble() ?? 0,
        deliveredBySku: (m['deliveredBySku'] as Map? ?? {})
            .map((k, v) => MapEntry(k.toString(), (v as num).toInt())),
        serials: (m['serials'] as List? ?? []).cast<String>(),
      );
}

class TripData {
  final String id;
  final String vehicleId;
  final String vehicleName;
  final double usedWeight;
  final double usedVolume;
  final double totalCod;
  final List<TripStop> stops;
  final int currentIndex;

  TripData({
    required this.id,
    required this.vehicleId,
    required this.vehicleName,
    required this.usedWeight,
    required this.usedVolume,
    required this.totalCod,
    required this.stops,
    this.currentIndex = 0,
  });

  TripData copyWith({
    double? usedWeight,
    double? usedVolume,
    double? totalCod,
    List<TripStop>? stops,
    int? currentIndex,
  }) => TripData(
        id: id,
        vehicleId: vehicleId,
        vehicleName: vehicleName,
        usedWeight: usedWeight ?? this.usedWeight,
        usedVolume: usedVolume ?? this.usedVolume,
        totalCod: totalCod ?? this.totalCod,
        stops: stops ?? this.stops,
        currentIndex: currentIndex ?? this.currentIndex,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'vehicleId': vehicleId,
        'vehicleName': vehicleName,
        'usedWeight': usedWeight,
        'usedVolume': usedVolume,
        'totalCod': totalCod,
        'stops': stops.map((s) => s.toMap()).toList(),
        'currentIndex': currentIndex,
      };

  factory TripData.fromMap(Map<String, dynamic> m) => TripData(
        id: m['id'] as String,
        vehicleId: m['vehicleId'] as String,
        vehicleName: m['vehicleName'] as String,
        usedWeight: (m['usedWeight'] as num).toDouble(),
        usedVolume: (m['usedVolume'] as num).toDouble(),
        totalCod: (m['totalCod'] as num).toDouble(),
        stops: (m['stops'] as List? ?? [])
            .map((e) => TripStop.fromMap(Map<String, dynamic>.from(e as Map)))
            .toList(),
        currentIndex: (m['currentIndex'] as num?)?.toInt() ?? 0,
      );
}
