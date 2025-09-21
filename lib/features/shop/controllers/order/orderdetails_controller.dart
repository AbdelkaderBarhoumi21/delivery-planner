import 'dart:async';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrdersdetailsController extends GetxController {
  static OrdersdetailsController get instance => Get.find();

  /// Non-nullable
  final Completer<GoogleMapController> completerController =
      Completer<GoogleMapController>();

  /// Non-nullable (sera initialisé dans onInit)
  late final CameraPosition cameraPosition;

  /// Non-nullable
  final List<Marker> markers = <Marker>[];

  double? lat;
  double? long;

  void addMarkers(LatLng latlng) {
    markers
      ..clear()
      ..add(Marker(markerId: const MarkerId('1'), position: latlng));
    lat = latlng.latitude;
    long = latlng.longitude;
    update();
  }

  void _initUserPosition() {
    // Exemple : point à Sousse
    cameraPosition = const CameraPosition(
      target: LatLng(35.8369, 10.5925),
      zoom: 12.5,
    );
    markers.add(
      const Marker(markerId: MarkerId('1'), position: LatLng(35.8369, 10.5925)),
    );
  }

  @override
  void onInit() {
    super.onInit();
    _initUserPosition();
  }
}
