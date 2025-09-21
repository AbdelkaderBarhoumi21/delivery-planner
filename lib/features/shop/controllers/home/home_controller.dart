// import 'package:flutter_ecommerce_app_v2/servies/hive_services.dart';
import 'package:get/get.dart';
import 'package:flutter_ecommerce_app_v2/servies/hive_services.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final assigned = <AssignedVM>[].obs;  // <- public

  @override
  void onInit() {
    super.onInit();
    _refresh();
  }

  void _refresh() {
    final ids = HiveService.assignedOrderIds();
    final shipDate = HiveService.shippingDate();
    assigned.value = ids.map((id) {
      final o = HiveService.orderById(id);
      final status = HiveService.statusOf(id);
      final custName = HiveService.customerName(o?['customerId'] as String);
      return AssignedVM(
        id: id,
        status: status,
        shippingDate: shipDate,
        customerName: custName,
      );
    }).toList();
  }

  Future<void> markDelivered(String id) async {
    await HiveService.setStatus(id, 'Delivered');
    _refresh();
  }
}

class AssignedVM {
  final String id;
  final String status;
  final DateTime shippingDate;
  final String customerName;
  AssignedVM({
    required this.id,
    required this.status,
    required this.shippingDate,
    required this.customerName,
  });
}
