import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_ecommerce_app_v2/servies/hive_services.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/models/trip_model.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/bottom_sheet/order_validate_sheet.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/models/order_validation_model.dart';

class OrderTrackingController extends GetxController {
  OrderTrackingController({required this.tripId, required this.orderIds});

  final String tripId;
  final List<String> orderIds;

  /// Trip courant (persisté dans Hive)
  final Rxn<TripData> tripRx = Rxn<TripData>();

  /// Stepper
  final RxInt currentStep = 0.obs;
  final RxBool isCompleted = false.obs;

  /// Logs pour l’UI (dérivés de l’état)
  final RxList<String> logs = <String>[].obs;

  // ────────────────────────────────────────────────────────────────────────────
  // Getters utiles
  // ────────────────────────────────────────────────────────────────────────────
  List<String> get remaining {
    final t = tripRx.value;
    if (t == null) return [];
    return t.stops
        .where((s) => s.status != StopStatus.completed)
        .map((s) => s.orderId)
        .toList();
  }

  int get currentIndex => tripRx.value?.currentIndex ?? 0;

  TripStop? get currentStop =>
      (tripRx.value != null && tripRx.value!.stops.isNotEmpty)
      ? tripRx.value!.stops[currentIndex]
      : null;

  // ────────────────────────────────────────────────────────────────────────────
  // Lifecycle
  // ────────────────────────────────────────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    _loadTrip();
  }

  // ────────────────────────────────────────────────────────────────────────────
  // Chargement / Sauvegarde
  // ────────────────────────────────────────────────────────────────────────────
  void _loadTrip() {
    final t = HiveService.getTrip(tripId);
    if (t == null) return;
    tripRx.value = t;
    _recomputeStepper(t);
    _recomputeLogs(t);
  }

  Future<void> _saveTrip(TripData t) async {
    await HiveService.upsertTrip(t);
    tripRx.value = t;
    _recomputeStepper(t);
    _recomputeLogs(t);
  }

  void _recomputeStepper(TripData t) {
    final allCompleted =
        t.stops.isNotEmpty &&
        t.stops.every((s) => s.status == StopStatus.completed);

    isCompleted.value = allCompleted;

    if (allCompleted) {
      currentStep.value = 2; // Completed
    } else if (t.stops.any((s) => s.status == StopStatus.inTransit)) {
      currentStep.value = 1; // In-Transit
    } else {
      currentStep.value = 0; // Pending
    }
  }

  void _recomputeLogs(TripData t) {
    final lines = <String>[];
    for (final s in t.stops.where((x) => x.status == StopStatus.completed)) {
      final cod = s.codCollected.toStringAsFixed(2);
      final skuParts = s.deliveredBySku.entries
          .map((e) => '${e.key}:${e.value}')
          .join(', ');
      final sn = s.serials.isEmpty ? '' : ', SN=${s.serials.join('/')}';
      lines.add('• ${s.orderId} validated (COD \$$cod, $skuParts$sn)');
    }
    logs
      ..clear()
      ..addAll(lines);
  }

  // ────────────────────────────────────────────────────────────────────────────
  // Helpers métier
  // ────────────────────────────────────────────────────────────────────────────
  List<String> _parseSerials(String raw) => raw
      .split(RegExp(r'[,\s]+'))
      .map((s) => s.trim())
      .where((s) => s.isNotEmpty)
      .toList();

  Map<String, int> _expectedForOrder(Map<String, dynamic> order) {
    final items = (order['items'] as List)
        .map((e) => Map<String, dynamic>.from(e as Map))
        .toList();
    return {
      for (final i in items)
        (i['sku'] as String): (i['quantity'] as num).toInt(),
    };
  }

  bool _isSkuSerialTracked(Map<String, dynamic> order, String sku) {
    final items = (order['items'] as List)
        .map((e) => Map<String, dynamic>.from(e as Map))
        .toList();
    final it = items.firstWhere(
      (m) => (m['sku'] as String?) == sku,
      orElse: () => const {},
    );
    return (it['serialTracked'] as bool?) == true;
  }

  // ────────────────────────────────────────────────────────────────────────────
  // Transitions utilitaires (mettent aussi à jour le statut UI dans Hive)
  // ────────────────────────────────────────────────────────────────────────────

  Future<void> _startTrip(TripData t) async {
    final updated = <TripStop>[];
    final futures = <Future>[];

    for (final s in t.stops) {
      if (s.status == StopStatus.completed) {
        updated.add(s);
      } else {
        updated.add(s.copyWith(status: StopStatus.inTransit));
        futures.add(HiveService.setStatus(s.orderId, 'In-Transit'));
      }
    }
    await Future.wait(futures);

    // curseur sur le premier non-completed
    int nextIndex = 0;
    for (int k = 0; k < updated.length; k++) {
      if (updated[k].status != StopStatus.completed) {
        nextIndex = k;
        break;
      }
    }
    await _saveTrip(t.copyWith(stops: updated, currentIndex: nextIndex));
  }

  Future<void> _completeStop({
    required TripData t,
    required int idx,
    required OrderValidationResult picked,
    required String sku,
    required int qty,
    required List<String> serials,
  }) async {
    final updatedStops = [...t.stops];
    updatedStops[idx] = updatedStops[idx].copyWith(
      status: StopStatus.completed,
      codCollected: picked.cod,
      deliveredBySku: <String, int>{sku: qty},
      serials: serials,
    );

    // Mettre à jour le statut UI (Home) immédiatement
    await HiveService.setStatus(picked.orderId, 'Completed');

    // Curseur → prochain non-completed (en repartant de l’index suivant)
    int nextIndex = t.currentIndex;
    for (int k = idx + 1; k < updatedStops.length; k++) {
      if (updatedStops[k].status != StopStatus.completed) {
        nextIndex = k;
        break;
      }
    }

    await _saveTrip(t.copyWith(stops: updatedStops, currentIndex: nextIndex));
  }

  Future<void> _failCurrentStop(TripData t) async {
    // Fail le premier stop non completed (à partir du curseur)
    int idx = t.currentIndex.clamp(0, t.stops.length - 1);
    if (t.stops[idx].status == StopStatus.completed) {
      for (int k = 0; k < t.stops.length; k++) {
        if (t.stops[k].status != StopStatus.completed) {
          idx = k;
          break;
        }
      }
    }

    final updated = [...t.stops];
    updated[idx] = updated[idx].copyWith(status: StopStatus.failed);

    // Mettre à jour le statut UI (Home)
    await HiveService.setStatus(updated[idx].orderId, 'Failed');

    // Avancer au prochain non-completed
    int nextIndex = idx;
    for (int k = idx + 1; k < updated.length; k++) {
      if (updated[k].status != StopStatus.completed) {
        nextIndex = k;
        break;
      }
    }
    await _saveTrip(t.copyWith(stops: updated, currentIndex: nextIndex));
  }

  // ────────────────────────────────────────────────────────────────────────────
  // Actions Stepper
  // ────────────────────────────────────────────────────────────────────────────
  Future<void> onContinue(BuildContext context) async {
    final t = tripRx.value;
    if (t == null) return;

    // START : tous les stops non complétés → In-Transit + statut UI
    if (currentStep.value == 0) {
      await _startTrip(t);
      return;
    }

    // VALIDATE : bottom-sheet avec dropdown d’orders restants
    if (currentStep.value == 1) {
      final OrderValidationResult? picked = await OrderValidateSheet.show(
        context,
        remaining,
      );
      if (picked == null) return;

      // Charger la commande pour vérifier les règles
      final order = HiveService.orderRawById(picked.orderId);
      if (order == null) return;

      // Attendus / flags
      final expected = _expectedForOrder(order); // {sku: qty}
      final isDiscounted = (order['isDiscounted'] as bool?) == true;
      final double requiredCod =
          (order['codAmount'] as num?)?.toDouble() ?? 0.0;

      // Récupère le SKU saisi ; si un seul SKU attendu on le déduit
      String sku = picked.sku.trim();
      if (sku.isEmpty && expected.length == 1) {
        sku = expected.keys.first;
      }

      // ---- RÈGLES ----
      // 0) SKU exists
      if (!expected.containsKey(sku)) {
        _toast('Unknown SKU "$sku" for order ${picked.orderId}.');
        return;
      }

      final int qty = picked.quantity;
      final int expQty = expected[sku]!;

      // 1) quantity bounds
      if (qty < 0) {
        _toast('Quantity for $sku cannot be negative.');
        return;
      }
      if (qty > expQty) {
        _toast('Quantity for $sku exceeds expected ($expQty).');
        return;
      }

      // forbid finishing with 0 delivered (use Fail instead)
      if (qty == 0) {
        _toast(
          'Delivered quantity must be at least 1. Use "Fail" if undelivered.',
        );
        return;
      }

      // 2) no partial when discounted
      if (isDiscounted && qty != expQty) {
        _toast(
          'Partial delivery is not allowed for discounted orders. Expected $expQty.',
        );
        return;
      }

      // 3) COD accuracy (no shortfall, ≤ $1 over allowed)
      const double overTolerance = 1.00;
      if (requiredCod > 0) {
        if (picked.cod + 1e-9 < requiredCod) {
          _toast(
            'COD shortfall. Required \$${requiredCod.toStringAsFixed(2)}, '
            'collected \$${picked.cod.toStringAsFixed(2)}.',
          );
          return;
        }
        if (picked.cod - requiredCod > overTolerance + 1e-9) {
          _toast(
            'Over-collection above \$${overTolerance.toStringAsFixed(2)} is not allowed.',
          );
          return;
        }
      } else {
        if (picked.cod > overTolerance + 1e-9) {
          _toast(
            'No COD expected for this order. Collected '
            '\$${picked.cod.toStringAsFixed(2)} is not allowed.',
          );
          return;
        }
      }

      // 4) serials required when SKU is serial-tracked
      final bool skuSerialTracked = _isSkuSerialTracked(order, sku);
      final serials = _parseSerials(picked.serial);
      if (skuSerialTracked) {
        if (serials.isEmpty) {
          _toast('Serial numbers are required for SKU $sku.');
          return;
        }
        if (serials.length != qty) {
          _toast(
            'Serials count (${serials.length}) must match delivered quantity ($qty).',
          );
          return;
        }
        if (serials.toSet().length != serials.length) {
          _toast('Duplicate serials detected.');
          return;
        }
      }

      // Commit
      final idx = t.stops.indexWhere((s) => s.orderId == picked.orderId);
      if (idx < 0) return;

      await _completeStop(
        t: t,
        idx: idx,
        picked: picked,
        sku: sku,
        qty: qty,
        serials: serials,
      );
      return;
    }

    // FINI → retour à la liste des trips
    if (currentStep.value == 2) {
      Get.back();
    }
  }

  void onCancel() {
    // Recul visuel (l’état persistant des stops ne revient pas en arrière)
    if (currentStep.value > 0) currentStep.value -= 1;
  }

  void onStepTapped(int index) {
    currentStep.value = index;
  }

  /// Fail (optionnel: raison libre)
  Future<void> markFail({String? reason}) async {
    final t = tripRx.value;
    if (t == null) return;
    await _failCurrentStop(t);
  }

  void _toast(String msg) {
    Get.snackbar('Validation', msg, snackPosition: SnackPosition.BOTTOM);
  }
}
