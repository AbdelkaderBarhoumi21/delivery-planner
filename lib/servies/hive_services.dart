import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const _planBox = 'plan'; // meta, vehicles, customers
  static const _tripsBox = 'trips'; // orders by id
  static const _uiBox = 'ui'; // assigned ids, statusById
  static const _metaBox = 'meta'; // flags (seeded)

  static Future<void> init() async {
    await Hive.initFlutter();
    await Future.wait([
      Hive.openBox(_planBox),
      Hive.openBox(_tripsBox),
      Hive.openBox(_uiBox),
      Hive.openBox(_metaBox),
    ]);

    // seed 1ère fois (sans spinner)
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

    // 🔧 force un Map<String,dynamic> / List<Map<String,dynamic>>
    final meta = Map<String, dynamic>.from(data['meta'] ?? {});
    final vehicles = (data['vehicles'] as List? ?? [])
        .map((e) => Map<String, dynamic>.from(e as Map))
        .toList();
    final customers = (data['customers'] as List? ?? [])
        .map((e) => Map<String, dynamic>.from(e as Map))
        .toList();

    await plan.put('meta', meta);
    await plan.put('vehicles', vehicles);
    await plan.put('customers', customers);

    final orders = (data['orders'] as List? ?? [])
        .map((e) => Map<String, dynamic>.from(e as Map))
        .toList();

    await trips.putAll({for (final o in orders) (o['id'] as String): o});

    await ui.put('assignedOrderIds', orders.map((o) => o['id']).toList());
    await ui.put('statusById', {
      for (final o in orders) (o['id'] as String): 'Pending',
    });
  }

  // ---- helpers pour lecture UI ----
  static List<String> assignedOrderIds() {
    return (Hive.box(_uiBox).get('assignedOrderIds') as List? ?? [])
        .cast<String>();
  }

  static Map<String, dynamic>? orderById(String id) {
    final raw = Hive.box(_tripsBox).get(id);
    return raw == null ? null : Map<String, dynamic>.from(raw);
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
    final raw = Hive.box(_planBox).get('customers');
    final list = (raw is List)
        ? raw.map((e) => Map<String, dynamic>.from(e as Map)).toList()
        : <Map<String, dynamic>>[];

    final match = list.firstWhere(
      (c) => c['id'] == customerId,
      orElse: () => const {'name': 'Unknown'},
    );

    return (match['name'] as String);
  }

  static DateTime shippingDate() {
    final meta = Map<String, dynamic>.from(
      Hive.box(_planBox).get('meta') ?? {},
    );
    final iso = meta['planDate'] as String?; // ex: "2025-09-17T00:00:00.000Z"
    return iso == null ? DateTime.now() : DateTime.parse(iso);
  }
}
