import 'dart:async';
import 'dart:ui';
import 'package:flutter_ecommerce_app_v2/features/shop/models/trip_summary_model.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


/// Contrôleur GetX pilotant la GoogleMap (markers / polylines)
/// et conservant la liste des trips créés.
class OrdersTripMapController extends GetxController {
  static OrdersTripMapController get instance => Get.find();

  // GoogleMap controller
  final Completer<GoogleMapController> completerController =
      Completer<GoogleMapController>();

  /// État de la carte
  final RxSet<Marker> _markers = <Marker>{}.obs;
  final RxSet<Polyline> _polylines = <Polyline>{}.obs;

  /// Exposition réactive (à utiliser dans Obx)
  RxSet<Marker> get markersRx => _markers;
  RxSet<Polyline> get polylinesRx => _polylines;

  /// Liste persistante des trips résumés (affichés en Card sous la map)
  final RxList<TripSummary> trips = <TripSummary>[].obs;

  /// Caméra de départ
  late final CameraPosition cameraPosition;

  /// IDs fixes des marqueurs qu’on affiche (1 véhicule + 2 stops démo)
  static const _vehicleId = MarkerId('vehicle');
  static const _order1Id = MarkerId('order1');
  static const _order2Id = MarkerId('order2');

  @override
  void onInit() {
    super.onInit();
    cameraPosition = const CameraPosition(
      target: LatLng(35.8369, 10.5925), // Sousse (exemple)
      zoom: 12.5,
    );
  }

  // ---------------------------------------------------------------------------
  // API publique : positionner les marqueurs
  // ---------------------------------------------------------------------------

  void setVehicle(LatLng p) {
    _markers.removeWhere((m) => m.markerId == _vehicleId);
    _markers.add(
      Marker(
        markerId: _vehicleId,
        position: p,
        infoWindow: const InfoWindow(title: 'Vehicle'),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueAzure,
        ),
      ),
    );
    _rebuildRoute();
    _fitCameraToAll();
  }

  void setOrder1(LatLng? p) {
    _markers.removeWhere((m) => m.markerId == _order1Id);
    if (p != null) {
      _markers.add(
        Marker(
          markerId: _order1Id,
          position: p,
          infoWindow: const InfoWindow(title: 'Order 1'),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueRed,
          ),
        ),
      );
    }
    _rebuildRoute();
    _fitCameraToAll();
  }

  void setOrder2(LatLng? p) {
    _markers.removeWhere((m) => m.markerId == _order2Id);
    if (p != null) {
      _markers.add(
        Marker(
          markerId: _order2Id,
          position: p,
          infoWindow: const InfoWindow(title: 'Order 2'),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueOrange,
          ),
        ),
      );
    }
    _rebuildRoute();
    _fitCameraToAll();
  }

  /// Appelé par l’écran après un “Save Trip” de la bottom-sheet.
  /// - Met à jour les marqueurs/route de **ce dernier trip**
  /// - Ajoute un **résumé persistant** dans [trips] (cartes sous la map)
void applyTripSelection({
  required String vehicleName,
  required double usedWeight,
  required double usedVolume,
  required double totalCod,            // <<< NEW
  required List<String> orderIds,
  required Map<String, LatLng> coords,
  required LatLng vehiclePos,
}) {
  setVehicle(vehiclePos);
  setOrder1(orderIds.isNotEmpty ? coords[orderIds[0]] : null);
  setOrder2(orderIds.length > 1 ? coords[orderIds[1]] : null);

  trips.add(TripSummary(
    id: _randomId(),
    vehicleName: vehicleName,
    usedWeight: usedWeight,
    usedVolume: usedVolume,
    totalCod: totalCod,                // <<< NEW
    orderIds: List.of(orderIds),
  ));
}

  /// (Optionnel) Vider la carte (route + marqueurs)
  void clearMap() {
    _polylines.clear();
    _markers.clear();
  }
  LatLng? _getPos(MarkerId id) {
    for (final m in _markers) {
      if (m.markerId == id) return m.position;
    }
    return null;
  }

  void _rebuildRoute() {
    final pts = <LatLng>[];

    final veh = _getPos(_vehicleId);
    final o1 = _getPos(_order1Id);
    final o2 = _getPos(_order2Id);

    if (veh != null) pts.add(veh);
    if (o1 != null) pts.add(o1);
    if (o2 != null) pts.add(o2);

    _polylines.clear();
    if (pts.length >= 2) {
      _polylines.add(
        Polyline(
          polylineId: const PolylineId('route'),
          points: pts,
          color: const Color(0xFF1565C0),
          width: 4,
        ),
      );
    }
  }

  Future<void> _fitCameraToAll() async {
    if (!completerController.isCompleted) return;
    final controller = await completerController.future;
    if (_markers.isEmpty) return;

    LatLngBounds? bounds;
    for (final m in _markers) {
      final p = m.position;
      bounds = (bounds == null)
          ? LatLngBounds(southwest: p, northeast: p)
          : LatLngBounds(
              southwest: LatLng(
                _min(bounds!.southwest.latitude, p.latitude),
                _min(bounds!.southwest.longitude, p.longitude),
              ),
              northeast: LatLng(
                _max(bounds!.northeast.latitude, p.latitude),
                _max(bounds!.northeast.longitude, p.longitude),
              ),
            );
    }
    if (bounds == null) return;

    try {
      await controller.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, 60),
      );
    } catch (_) {
      // Fallback si les bounds échouent (ex: trop serrés)
      await controller.animateCamera(
        CameraUpdate.newLatLng(_markers.first.position),
      );
    }
  }

  String _randomId() {
    final n = DateTime.now().millisecondsSinceEpoch.remainder(0xFFFFFF);
    return n.toRadixString(16);
  }

  double _min(double a, double b) => a < b ? a : b;
  double _max(double a, double b) => a > b ? a : b;
}
