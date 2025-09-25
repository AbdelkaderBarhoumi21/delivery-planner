// lib/features/shop/controllers/home/home_controller.dart
import 'dart:async';
import 'package:flutter_ecommerce_app_v2/features/shop/models/assign_order_model.dart';
import 'package:get/get.dart';
import 'package:flutter_ecommerce_app_v2/data/services/hive_services.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final assigned = <AssignedVM>[].obs;

  StreamSubscription? _uiWatch;
  StreamSubscription? _tripsWatch;

  @override
  void onInit() {
    super.onInit();
    _refresh();

    // Auto-refresh when either the UI box or trips box changes
    _uiWatch = Hive.box('ui').watch().listen((_) => _refresh());
    _tripsWatch = HiveService.watchTrips().listen((_) => _refresh());
  }

  @override
  void onClose() {
    _uiWatch?.cancel();
    _tripsWatch?.cancel();
    super.onClose();
  }

  void _refresh() {
    // Only show Pending or In-Transit
    const active = {'Pending', 'In-Transit'};

    final ids = HiveService.assignedOrderIds();
    final shipDate = HiveService.shippingDate();

    final list = <AssignedVM>[];
    for (final id in ids) {
      final status = HiveService.statusOf(id);
      if (!active.contains(status)) continue;

      final o = HiveService.orderById(id);
      final custName = HiveService.customerName(o?['customerId'] as String);
      list.add(AssignedVM(
        id: id,
        status: status,
        shippingDate: shipDate,
        customerName: custName,
      ));
    }
    assigned.value = list;
  }

  Future<void> markDelivered(String id) async {
    await HiveService.setStatus(id, 'Completed');
    _refresh();
  }
}


