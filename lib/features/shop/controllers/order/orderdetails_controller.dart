import 'dart:async';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_ecommerce_app_v2/servies/hive_services.dart';
import 'package:hive/hive.dart';

class OrdersdetailsController extends GetxController {
  static OrdersdetailsController get instance => Get.find();

  // input
  late final String orderId;

  // map
  final Completer<GoogleMapController> completerController = Completer();
  late CameraPosition cameraPosition;
  final RxList<Marker> markers = <Marker>[].obs;

  // données exposées
  late String customerName;
  late String customerAddress;
  late LatLng customerLatLng;
  late LatLng depotLatLng;
  late String status;
  late DateTime shippingDate;

  late double weightKg;
  late double volumeM3;
  late String paymentMethod; // "COD" / "Prepaid"
  late double codAmount;
  late String firstItemName;
  late int firstItemQty;

  // dérivées
  late double distanceKm;
  late String etaText;

  @override
  void onInit() {
    super.onInit();
    orderId = (Get.arguments?['orderId'] as String?) ?? '';

    // --------- Charger order & plan ---------
    final order = HiveService.orderById(orderId);

    // meta / depot
    final planBox = Hive.box('plan');
    final metaMap = _asStringMap(planBox.get('meta'));
    final depotMap = _asStringMap(metaMap['depot']);
    depotLatLng = LatLng(
      (depotMap['lat'] as num?)?.toDouble() ?? 25.2048,
      (depotMap['lon'] as num?)?.toDouble() ?? 55.2708,
    );
    shippingDate = HiveService.shippingDate();

    if (order == null) {
      customerName = 'Unknown';
      customerAddress =
          '${depotLatLng.latitude.toStringAsFixed(4)}, ${depotLatLng.longitude.toStringAsFixed(4)}';
      customerLatLng = depotLatLng;
      status = 'Pending';
      weightKg = 0;
      volumeM3 = 0;
      paymentMethod = 'Prepaid';
      codAmount = 0;
      firstItemName = '-';
      firstItemQty = 0;
    } else {
      // --------- Client ----------
      final customerId = order['customerId'] as String;
      final customersRaw = planBox.get('customers');
      final customers = _asListOfStringMap(customersRaw);

      final cust = customers.firstWhere(
        (c) => c['id'] == customerId,
        orElse: () => <String, dynamic>{},
      );

      customerName = (cust['name'] as String?) ?? 'Unknown';

      // adresse si présente, sinon coordonnées
      final loc = _asStringMap(cust['location']);
      final lat = (loc['lat'] as num?)?.toDouble();
      final lon = (loc['lon'] as num?)?.toDouble();
      customerLatLng = LatLng(
        lat ?? depotLatLng.latitude,
        lon ?? depotLatLng.longitude,
      );

      final addr = cust['address'] as String?;
      customerAddress = (addr != null && addr.trim().isNotEmpty)
          ? addr
          : '${customerLatLng.latitude.toStringAsFixed(4)}, ${customerLatLng.longitude.toStringAsFixed(4)}';

      // --------- Statut ----------
      status = HiveService.statusOf(orderId);

      // --------- Items / poids / volume ----------
      final items = _asListOfStringMap(order['items']);
      double w = 0, v = 0;
      for (final it in items) {
        final q = (it['quantity'] as num?)?.toInt() ?? 0;
        final iw = (it['weight'] as num?)?.toDouble() ?? 0;
        final iv = (it['volume'] as num?)?.toDouble() ?? 0;
        w += iw * q;
        v += iv * q;
      }
      weightKg = w;
      volumeM3 = v;

      if (items.isNotEmpty) {
        firstItemName = (items.first['name'] as String?) ?? '-';
        firstItemQty = (items.first['quantity'] as num?)?.toInt() ?? 0;
      } else {
        firstItemName = '-';
        firstItemQty = 0;
      }

      // --------- Paiement ----------
      codAmount = (order['codAmount'] as num?)?.toDouble() ?? 0;
      paymentMethod = codAmount > 0 ? 'COD' : 'Prepaid';
    }

    // --------- Distance / ETA ----------
    distanceKm = _haversineKm(depotLatLng, customerLatLng);
    etaText = _formatEta(distanceKm);

    // --------- Map ----------
    cameraPosition = CameraPosition(target: customerLatLng, zoom: 12);

    // Icônes distinctes (client = rouge, dépôt = bleu azur)
    final customerIcon = BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueRed,
    );
    final depotIcon = BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueAzure,
    );

    markers.assignAll([
      Marker(
        markerId: const MarkerId('customer'),
        position: customerLatLng,
        icon: customerIcon, // <<<<<< DIFF
        infoWindow: InfoWindow(title: customerName, snippet: customerAddress),
      ),
      Marker(
        markerId: const MarkerId('depot'),
        position: depotLatLng,
        icon: depotIcon, // <<<<<< DIFF
        infoWindow: const InfoWindow(title: 'Depot'),
      ),
    ]);
  }

  // Fit bounds après création de la map
  Future<void> fitBounds() async {
    if (!completerController.isCompleted) return;
    final ctrl = await completerController.future;
    final bounds = _boundsFrom(depotLatLng, customerLatLng);
    await ctrl.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }

  // --------- Utils internes ---------
  Map<String, dynamic> _asStringMap(dynamic v) {
    if (v is Map) return Map<String, dynamic>.from(v);
    return <String, dynamic>{};
  }

  List<Map<String, dynamic>> _asListOfStringMap(dynamic v) {
    if (v is List) {
      return v.map((e) => _asStringMap(e)).toList();
    }
    return <Map<String, dynamic>>[];
  }

  LatLngBounds _boundsFrom(LatLng a, LatLng b) {
    return LatLngBounds(
      southwest: LatLng(
        math.min(a.latitude, b.latitude),
        math.min(a.longitude, b.longitude),
      ),
      northeast: LatLng(
        math.max(a.latitude, b.latitude),
        math.max(a.longitude, b.longitude),
      ),
    );
  }

  double _haversineKm(LatLng a, LatLng b) {
    const R = 6371.0;
    final dLat = _deg2rad(b.latitude - a.latitude);
    final dLon = _deg2rad(b.longitude - a.longitude);
    final la1 = _deg2rad(a.latitude);
    final la2 = _deg2rad(b.latitude);
    final h =
        math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(la1) * math.cos(la2) * math.sin(dLon / 2) * math.sin(dLon / 2);
    final c = 2 * math.atan2(math.sqrt(h), math.sqrt(1 - h));
    return R * c;
  }

  double _deg2rad(double d) => d * math.pi / 180.0;

  String _formatEta(double km) {
    final minutes = (km / 35.0 * 60).clamp(1, 999).round(); // ~35km/h
    final h = minutes ~/ 60;
    final m = minutes % 60;
    if (h > 0) return '${h}h ${m}m';
    return '${m}m';
  }
}
