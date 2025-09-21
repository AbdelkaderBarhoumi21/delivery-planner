import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_ecommerce_app_v2/servies/hive_services.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/models/trip_model.dart';

class TripCardVM {
  final String id;
  final String vehicleName;
  final double usedWeight;
  final double usedVolume;
  final double totalCod;
  final List<String> orderIds; // dérivé des stops
  TripCardVM({
    required this.id,
    required this.vehicleName,
    required this.usedWeight,
    required this.usedVolume,
    required this.totalCod,
    required this.orderIds,
  });
}

class OrdersTripMapController extends GetxController {
  static OrdersTripMapController get instance => Get.find();

  // Google Map
  final Completer<GoogleMapController> completerController = Completer();
  late CameraPosition cameraPosition;
  final RxSet<Marker> markersRx = <Marker>{}.obs;
  final RxSet<Polyline> polylinesRx = <Polyline>{}.obs;

  // Trips (cartes UI)
  final RxList<TripCardVM> trips = <TripCardVM>[].obs;
  final RxnString selectedTripId = RxnString();

  // Depot
  late LatLng depot;

  @override
  void onInit() {
    super.onInit();
    final d = HiveService.depotLatLon();
    depot = LatLng(d['lat']!, d['lon']!);
    cameraPosition = CameraPosition(target: depot, zoom: 12);

    _loadTripsFromHive();
    // refresh à chaque mutation de la box 'trips'
    HiveService.watchTrips().listen((_) => _loadTripsFromHive());
  }

  // ---------------------------------------------------------------------------
  // Chargement & sélection
  // ---------------------------------------------------------------------------
  void _loadTripsFromHive() {
    final raw = HiveService.getAllTripsRaw();
    final list = raw.map(TripData.fromMap).toList()
      ..sort((a, b) => b.id.compareTo(a.id));

    trips.value = list
        .map(
          (t) => TripCardVM(
            id: t.id,
            vehicleName: t.vehicleName,
            usedWeight: t.usedWeight,
            usedVolume: t.usedVolume,
            totalCod: t.totalCod,
            orderIds: t.stops.map((s) => s.orderId).toList(),
          ),
        )
        .toList();

    // conserver la sélection si possible
    final keep = selectedTripId.value;
    if (keep != null && list.any((t) => t.id == keep)) {
      _drawTripOnMap(list.firstWhere((t) => t.id == keep));
    } else if (list.isNotEmpty) {
      selectedTripId.value = list.first.id;
      _drawTripOnMap(list.first);
    } else {
      selectedTripId.value = null;
      _clearMap();
    }
  }

  /// Sélection publique d’un trip (depuis un tap sur la carte UI)
  void selectTrip(String tripId) {
    final data = HiveService.getAllTripsRaw()
        .map(TripData.fromMap)
        .firstWhere((t) => t.id == tripId);
    selectedTripId.value = tripId;
    _drawTripOnMap(data);
  }

  // ---------------------------------------------------------------------------
  // Création de trip (depuis la bottom-sheet)
  // ---------------------------------------------------------------------------
  Future<void> createTrip({
    required String vehicleId,
    required String vehicleName,
    required List<String> orderIds,
  }) async {
    double w = 0, v = 0, cod = 0;

    for (final id in orderIds) {
      final o = HiveService.orderRawById(id);
      if (o == null) continue;

      final items = (o['items'] as List)
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();

      for (final it in items) {
        final q = (it['quantity'] as num).toInt();
        w += ((it['weight'] as num).toDouble()) * q;
        v += ((it['volume'] as num).toDouble()) * q;
      }
      cod += (o['codAmount'] as num?)?.toDouble() ?? 0.0;
    }

    // Construire les stops PENDING
    final stops = <TripStop>[for (final id in orderIds) TripStop(orderId: id)];

    final id = 'trip_${DateTime.now().microsecondsSinceEpoch.toRadixString(36)}';
    final trip = TripData(
      id: id,
      vehicleId: vehicleId,
      vehicleName: vehicleName,
      usedWeight: w,
      usedVolume: v,
      totalCod: cod,
      stops: stops,
      currentIndex: 0,
    );

    await HiveService.upsertTrip(trip);

    // sélection auto du nouveau trip
    selectedTripId.value = trip.id;
    _drawTripOnMap(trip);
  }

  // ---------------------------------------------------------------------------
  // Map helpers
  // ---------------------------------------------------------------------------
  void _clearMap() {
    markersRx
      ..clear()
      ..add(
        Marker(
          markerId: const MarkerId('depot'),
          position: depot,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueAzure,
          ),
          infoWindow: const InfoWindow(title: 'Depot'),
        ),
      );
    polylinesRx.clear();
  }

  void _drawTripOnMap(TripData t) {
    final customerPoints = <LatLng>[];
    final stopMarkers = <Marker>[];

    final orderIds = t.stops.map((s) => s.orderId).toList();

    for (int i = 0; i < orderIds.length; i++) {
      final o = HiveService.orderRawById(orderIds[i]);
      if (o == null) continue;
      final cust = HiveService.customerById(o['customerId'] as String);
      if (cust == null) continue;

      final loc = Map<String, dynamic>.from(cust['location'] as Map);
      final pt = LatLng(
        (loc['lat'] as num).toDouble(),
        (loc['lon'] as num).toDouble(),
      );
      customerPoints.add(pt);

      stopMarkers.add(
        Marker(
          markerId: MarkerId('stop_${i + 1}_${orderIds[i]}'),
          position: pt,
          infoWindow: InfoWindow(
            title: orderIds[i],
            snippet: cust['name'] as String?,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    }

    final mks = <Marker>{
      Marker(
        markerId: const MarkerId('depot'),
        position: depot,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindow: const InfoWindow(title: 'Depot'),
      ),
      ...stopMarkers,
    };

    final points = <LatLng>[depot, ...customerPoints];

    final poly = Polyline(
      polylineId: PolylineId('trip_${t.id}'),
      points: points,
      width: 4,
      color: const Color(0xFF2962FF),
    );

    markersRx
      ..clear()
      ..addAll(mks);
    polylinesRx
      ..clear()
      ..add(poly);

    _fitAll(points);
  }

  Future<void> _fitAll(List<LatLng> pts) async {
    if (pts.isEmpty) return;
    if (!completerController.isCompleted) return;
    final ctrl = await completerController.future;
    final b = _boundsFrom(pts);
    await ctrl.animateCamera(CameraUpdate.newLatLngBounds(b, 48));
  }

  LatLngBounds _boundsFrom(List<LatLng> pts) {
    double? minLat, minLon, maxLat, maxLon;
    for (final p in pts) {
      minLat = (minLat == null) ? p.latitude : math.min(minLat, p.latitude);
      minLon = (minLon == null) ? p.longitude : math.min(minLon, p.longitude);
      maxLat = (maxLat == null) ? p.latitude : math.max(maxLat, p.latitude);
      maxLon = (maxLon == null) ? p.longitude : math.max(maxLon, p.longitude);
    }
    return LatLngBounds(
      southwest: LatLng(minLat!, minLon!),
      northeast: LatLng(maxLat!, maxLon!),
    );
  }
}
