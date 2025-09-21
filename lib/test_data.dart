import 'package:flutter_ecommerce_app_v2/features/shop/models/order_option.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/models/vehicle_model.dart';

class TestData {
  //VehicleOption data
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
      capacityWeight: 1500,
      capacityVolume: 12.0,
      fillRate: 0.85,
    ),
  ];
  static final List<OrderOption> orders = [
    OrderOption(
      id: 'ORD-001',
      displayName: 'ORD-001',
      weight: 25.0,
      volume: 0.40,
    ),
    OrderOption(
      id: 'ORD-002',
      displayName: 'ORD-002',
      weight: 5.0,
      volume: 0.02,
    ),
  ];
}
