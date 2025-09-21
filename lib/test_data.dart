// lib/test_data.dart
import 'package:flutter_ecommerce_app_v2/features/shop/models/order_option.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/models/vehicle_model.dart';

class TestData {
  static final List<VehicleOption> vehicles = [
    VehicleOption(
      id: 'v01',
      name: 'Sprinter Van',
      capacityWeight: 1500,
      capacityVolume: 12.0,
      fillRate: 0.85,
    ),
    VehicleOption(
      id: 'v02',
      name: 'MotoCiycle',
      capacityWeight: 120,   // valeur réaliste pour la moto
      capacityVolume: 0.25,  // idem
      fillRate: 0.85,
    ),
  ];

  static final List<OrderOption> orders = [
    OrderOption(
      id: 'ORD-001',
      displayName: 'ORD-001',
      weight: 25.0,
      volume: 0.40,
      codAmount: 150.75, // <<< NEW
    ),
    OrderOption(
      id: 'ORD-002',
      displayName: 'ORD-002',
      weight: 5.0,
      volume: 0.02,
      codAmount: 199.50, // <<< NEW
    ),
  ];
}
