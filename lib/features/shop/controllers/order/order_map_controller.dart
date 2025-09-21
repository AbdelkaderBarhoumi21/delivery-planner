// lib/features/shop/controllers/order/order_map_controller.dart
import 'dart:async';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui';

class OrdersTripMapController extends GetxController {
  static OrdersTripMapController get instance => Get.find();

  final Completer<GoogleMapController> completerController =
      Completer<GoogleMapController>();

  // Observables
  final RxSet<Marker> _markers = <Marker>{}.obs;
  final RxSet<Polyline> _polylines = <Polyline>{}.obs;

  // 👉 expose comme Rx pour qu’Obx s’abonne
  RxSet<Marker> get markersRx => _markers;
  RxSet<Polyline> get polylinesRx => _polylines;

  late final CameraPosition cameraPosition;

  static const _vehicleId = MarkerId('vehicle');
  static const _order1Id  = MarkerId('order1');
  static const _order2Id  = MarkerId('order2');

  @override
  void onInit() {
    super.onInit();
    cameraPosition = const CameraPosition(
      target: LatLng(35.8369, 10.5925),
      zoom: 12.5,
    );
    setVehicle(const LatLng(35.8369, 10.5925));
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
    final o1  = _getPos(_order1Id);
    final o2  = _getPos(_order2Id);

    if (veh != null) pts.add(veh);
    if (o1  != null) pts.add(o1);
    if (o2  != null) pts.add(o2);

    _polylines.clear();
    if (pts.length >= 2) {
      _polylines.add(
        const Polyline(
          polylineId: PolylineId('route'),
          points: [], // placeholder, on remplace juste après
          color: Color(0xFF1565C0),
          width: 4,
        ),
      );
      // remplace les points (workaround si tu veux éviter const)
      _polylines
        ..clear()
        ..add(Polyline(
          polylineId: const PolylineId('route'),
          points: pts,
          color: const Color(0xFF1565C0),
          width: 4,
        ));
    }
  }

  void setVehicle(LatLng p) {
    _markers.removeWhere((m) => m.markerId == _vehicleId);
    _markers.add(Marker(
      markerId: _vehicleId,
      position: p,
      infoWindow: const InfoWindow(title: 'Vehicle'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    ));
    _rebuildRoute();
    _fitCameraToAll();
  }

  void setOrder1(LatLng? p) {
    _markers.removeWhere((m) => m.markerId == _order1Id);
    if (p != null) {
      _markers.add(Marker(
        markerId: _order1Id,
        position: p,
        infoWindow: const InfoWindow(title: 'Order 1'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ));
    }
    _rebuildRoute();
    _fitCameraToAll();
  }

  void setOrder2(LatLng? p) {
    _markers.removeWhere((m) => m.markerId == _order2Id);
    if (p != null) {
      _markers.add(Marker(
        markerId: _order2Id,
        position: p,
        infoWindow: const InfoWindow(title: 'Order 2'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      ));
    }
    _rebuildRoute();
    _fitCameraToAll();
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
      await controller.animateCamera(
        CameraUpdate.newLatLng(_markers.first.position),
      );
    }
  }

  double _min(double a, double b) => a < b ? a : b;
  double _max(double a, double b) => a > b ? a : b;
}
