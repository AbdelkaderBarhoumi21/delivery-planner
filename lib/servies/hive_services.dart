// lib/servies/hive_services.dart
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_ecommerce_app_v2/features/shop/models/order_option.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/models/trip_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  // ---- Boxes ----
  static const _planBox = 'plan'; // meta, vehicles, customers
  static const _tripsBox = 'trips'; // orders by id, trips: trip_*
  static const _uiBox = 'ui'; // assigned ids, statusById
  static const _metaBox = 'meta'; // flags (seeded)

  // -------------------------------
  // Init + Seed (une seule fois)
  // -------------------------------
  static Future<void> init() async {
    await Hive.initFlutter();
    await Future.wait([
      Hive.openBox(_planBox),
      Hive.openBox(_tripsBox),
      Hive.openBox(_uiBox),
      Hive.openBox(_metaBox),
    ]);

    final meta = Hive.box(_metaBox);
    if (meta.get('seeded') != true) {
      final raw = await rootBundle.loadString('assets/seed/plan.json');
      final data = jsonDecode(raw) as Map<String, dynamic>;
      await _seedFromAsset(data);
      await meta.put('seeded', true);
    }
  }

  static Future<void> _seedFromAsset(Map<String, dynamic> data) async {
    final plan = Hive.box(_planBox);
    final trips = Hive.box(_tripsBox);
    final ui = Hive.box(_uiBox);

    // Sécuriser les types (Map/List)
    final meta = Map<String, dynamic>.from(data['meta'] ?? {});
    final vehicles = (data['vehicles'] as List? ?? [])
        .map((e) => Map<String, dynamic>.from(e as Map))
        .toList();
    final customers = (data['customers'] as List? ?? [])
        .map((e) => Map<String, dynamic>.from(e as Map))
        .toList();
    final orders = (data['orders'] as List? ?? [])
        .map((e) => Map<String, dynamic>.from(e as Map))
        .toList();

    // plan
    await plan.put('meta', meta);
    await plan.put('vehicles', vehicles);
    await plan.put('customers', customers);
    await plan.put(
      'orders',
      orders,
    ); // garde aussi la liste complète si tu veux

    // indexer chaque order par id dans 'trips' (accès direct)
    await trips.putAll({for (final o in orders) (o['id'] as String): o});

    // petit état UI (ex: liste assignée + statut)
    await ui.put('assignedOrderIds', orders.map((o) => o['id']).toList());
    await ui.put('statusById', {
      for (final o in orders) (o['id'] as String): 'Pending',
    });
  }

  // -------------------------------
  // Helpers génériques de conversion
  // -------------------------------
  static Map<String, dynamic> _asMap(dynamic v) =>
      v is Map ? Map<String, dynamic>.from(v) : <String, dynamic>{};

  static List<Map<String, dynamic>> _asListMap(dynamic v) =>
      v is List ? v.map((e) => _asMap(e)).toList() : <Map<String, dynamic>>[];

  // -------------------------------
  // Lectures courantes (UI)
  // -------------------------------
  static List<String> assignedOrderIds() {
    return (Hive.box(_uiBox).get('assignedOrderIds') as List? ?? [])
        .cast<String>();
  }

  static Map<String, dynamic>? orderById(String id) {
    final raw = Hive.box(_tripsBox).get(id);
    return raw == null ? null : Map<String, dynamic>.from(raw as Map);
  }

  static String statusOf(String id) {
    final map = Map<String, dynamic>.from(
      Hive.box(_uiBox).get('statusById') ?? {},
    );
    return (map[id] as String?) ?? 'Pending';
  }

  static Future<void> setStatus(String id, String status) async {
    final ui = Hive.box(_uiBox);
    final map = Map<String, dynamic>.from(ui.get('statusById') ?? {});
    map[id] = status;
    await ui.put('statusById', map);
  }

  static String customerName(String customerId) {
    final list = _asListMap(Hive.box(_planBox).get('customers'));
    final match = list.firstWhere(
      (c) => c['id'] == customerId,
      orElse: () => const {'name': 'Unknown'},
    );
    return (match['name'] as String);
  }

  static DateTime shippingDate() {
    final meta = _asMap(Hive.box(_planBox).get('meta'));
    final iso = meta['planDate'] as String?;
    return iso == null ? DateTime.now() : DateTime.parse(iso);
  }

  // -------------------------------
  // Données du plan (vehicles, orders, customers, depot)
  // -------------------------------
  static List<Map<String, dynamic>> vehiclesRaw() =>
      _asListMap(Hive.box(_planBox).get('vehicles'));

 static List<Map<String, dynamic>> ordersRaw() {
  final list = _asListMap(Hive.box(_planBox).get('orders'));
  if (list.isNotEmpty) return list;

  // Fallback: gather orders indexed by id in "trips" box (if you ever stored them there)
  final trips = Hive.box(_tripsBox);
  final out = <Map<String, dynamic>>[];
  for (final k in trips.keys) {
    if (k is String && k.startsWith('ORD-')) {
      out.add(Map<String, dynamic>.from(trips.get(k) as Map));
    }
  }
  return out;
}// copie liste complète

  static Map<String, dynamic>? orderRawById(String id) {
    // priorité: lookup direct par id (rapide)
    final raw = Hive.box(_tripsBox).get(id);
    if (raw != null) return Map<String, dynamic>.from(raw as Map);

    // fallback: recherche dans la liste 'orders' du plan
    for (final o in ordersRaw()) {
      if (o['id'] == id) return o;
    }
    return null;
  }

  static Map<String, dynamic>? customerById(String id) {
    final list = _asListMap(Hive.box(_planBox).get('customers'));
    for (final c in list) {
      if (c['id'] == id) return c;
    }
    return null;
  }

  static Map<String, double> depotLatLon() {
    final meta = _asMap(Hive.box(_planBox).get('meta'));
    final d = _asMap(meta['depot']);
    return {
      'lat': (d['lat'] as num?)?.toDouble() ?? 25.2048,
      'lon': (d['lon'] as num?)?.toDouble() ?? 55.2708,
    };
  }

  // -------------------------------
  // Options UI (pour bottom sheet)
  // -------------------------------
  /// Retourne chaque véhicule en Map<String,dynamic> (id, name, capacity, fillRate)
  static List<Map<String, dynamic>> vehicleOptions() => vehiclesRaw();

  /// Calcule pour chaque order: poids/volume totaux (somme items*qty) + COD
static List<Map<String, dynamic>> orderOptions() {
  final list = ordersRaw();
  return list.map((o) {
    final items = _asListMap(o['items']);
    double w = 0, v = 0;
    for (final it in items) {
      final q = (it['quantity'] as num).toInt();
      w += ((it['weight'] as num).toDouble()) * q;
      v += ((it['volume'] as num).toDouble()) * q;
    }
    return {
      'id': o['id'],
      'codAmount': (o['codAmount'] as num?)?.toDouble() ?? 0.0,
      'weight': w,
      'volume': v,
    };
  }).toList(growable: false);
}

  // -------------------------------
  // Trips (persistences & streams)
  // -------------------------------
  /// Liste toutes les entrées `trip_*` en Map (pour reconstruire tes VMs)
  static List<Map<String, dynamic>> getAllTripsRaw() {
    final box = Hive.box(_tripsBox);
    final list = <Map<String, dynamic>>[];
    for (final key in box.keys) {
      if (key is String && key.startsWith('trip_')) {
        list.add(Map<String, dynamic>.from(box.get(key) as Map));
      }
    }
    return list;
  }

  /// Sauve/écrase un trip (clé: tripId)
  static Future<void> saveTripMap(
    String tripId,
    Map<String, dynamic> map,
  ) async {
    await Hive.box(_tripsBox).put(tripId, map);
  }

  /// Supprime un trip
  static Future<void> deleteTrip(String tripId) async {
    await Hive.box(_tripsBox).delete(tripId);
  }

  /// Stream sur toute la box `trips` (ajouts/suppressions/modifs)
  static Stream<BoxEvent> watchTrips() => Hive.box(_tripsBox).watch();
  // lib/servies/hive_services.dart

// --- Options UI (pour bottom sheet) ---
final oOpts = HiveService.ordersRaw()
    .map((e) => OrderOption.fromHive(e))
    .toList(growable: false);
// lib/servies/hive_services.dart  (ajouts)

static Map<String, dynamic>? tripRaw(String tripId) {
  final raw = Hive.box(_tripsBox).get(tripId);
  return raw == null ? null : Map<String, dynamic>.from(raw as Map);
}

static Future<void> upsertTrip(TripData t) async {
  await Hive.box(_tripsBox).put(t.id, t.toMap());
}

static Future<TripData?> updateStop(
  String tripId,
  int stopIndex,
  TripStop Function(TripStop) updater, {
  int? newCurrentIndex,
}) async {
  final raw = tripRaw(tripId);
  if (raw == null) return null;
  final trip = TripData.fromMap(raw);
  if (stopIndex < 0 || stopIndex >= trip.stops.length) return trip;

  final newStops = [...trip.stops];
  newStops[stopIndex] = updater(newStops[stopIndex]);

  final updated = trip.copyWith(
    stops: newStops,
    currentIndex: newCurrentIndex ?? trip.currentIndex,
  );
  await upsertTrip(updated);
  return updated;
}

}
