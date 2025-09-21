// lib/features/shop/screens/order/history_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:flutter_ecommerce_app_v2/common/styles/padding.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/appbar/appbar.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/appbar/tab_bar.dart';
import 'package:flutter_ecommerce_app_v2/common/widget/icons/circular_icon.dart';

import 'package:flutter_ecommerce_app_v2/features/shop/controllers/order/order_history_controller.dart';
import 'package:flutter_ecommerce_app_v2/features/shop/screens/order/widgets/order_history_card.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Instancie (ou récupère) le controller une seule fois pour l'écran
    final c = Get.put(OrderHistoryController());

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: UAppBar(
          title: Text(
            'Order History',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: const [
            AppCircularIcon(
              backgroundColor: Colors.transparent,
              icon: Iconsax.notification_status,
            ),
          ],
        ),
        body: Padding(
          padding: AppPadding.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AppTabBar(
                tabs: [
                  Tab(text: 'Active'),
                  Tab(text: 'Completed'),
                  Tab(text: 'Cancelled'),
                ],
              ),
              const SizedBox(height: 8),

              // On lit les Rx dans un Obx pour enregistrer les dépendances.
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Obx(() {
                    // Faites une copie immuable pour éviter toute mutation accidentelle
                    final active = c.active.toList(growable: false);
                    final completed = c.completed.toList(growable: false);
                    final cancelled = c.cancelled.toList(growable: false);

                    return TabBarView(
                      children: [
                        // ACTIVE = Pending + In-Transit
                        AppOrderHistoryCard(
                          items: active,
                          shrinkWrap: true,
                          nonScrollable: true,
                          // Ouvre le tracking de l’ordre sélectionné
                          onTap: (orderId) => c.openInTracking(orderId),
                        ),

                        // COMPLETED
                        AppOrderHistoryCard(
                          items: completed,
                          shrinkWrap: true,
                          nonScrollable: true,
                          onTap: (orderId) {
                            // ici vous pouvez ouvrir un détail "lecture seule" si besoin
                          },
                        ),

                        // CANCELLED
                        AppOrderHistoryCard(
                          items: cancelled,
                          shrinkWrap: true,
                          nonScrollable: true,
                          onTap: (orderId) {
                            // idem : détail, raison d’annulation, etc.
                          },
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
