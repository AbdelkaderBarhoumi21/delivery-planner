import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';

/// États possibles d’une commande.
enum OrderState { activated, completed, failed, cancelled }

/// Timeline « Activated → (Completed | Failed | Cancelled) ».
class OrderTimeline extends StatelessWidget {
  const OrderTimeline({super.key, required this.state});

  final OrderState state;

  @override
  Widget build(BuildContext context) {
    final labels = const ['Activated', 'Completed', 'Failed', 'Cancelled'];

    // Indices actifs selon l’état courant.
    final Set<int> active = switch (state) {
      OrderState.activated => {0},
      OrderState.completed => {0, 1},
      OrderState.failed    => {0, 2},
      OrderState.cancelled => {0, 3},
    };

    final cs = Theme.of(context).colorScheme;

    // ---- INDICATEURS (vrais widgets) ----
    Widget indicatorFor(int i) {
      final isActive = active.contains(i);

      // 0: Activated
      if (i == 0) {
        return isActive
            ? const DotIndicator() // point plein
            : OutlinedDotIndicator(
                color: cs.outlineVariant,
                borderWidth: 2,
              );
      }

      // 1: Completed (vert + check)
      if (i == 1) {
        return DotIndicator(
          color: isActive ? Colors.green : cs.outlineVariant,
          child: isActive
              ? const Icon(Icons.check, size: 12, color: Colors.white)
              : null,
        );
      }

      // 2: Failed (rouge + croix)
      if (i == 2) {
        return DotIndicator(
          color: isActive ? Colors.red : cs.outlineVariant,
          child: isActive
              ? const Icon(Icons.close, size: 12, color: Colors.white)
              : null,
        );
      }

      // 3: Cancelled (gris + tiret)
      return DotIndicator(
        color: isActive ? Colors.grey : cs.outlineVariant,
        child: isActive
            ? const Icon(Icons.remove, size: 12, color: Colors.white)
            : null,
      );
    }

    // Connecteur solide si les deux nœuds voisins sont actifs, sinon pointillés.
    Widget connectorFor(int i) {
      final bothActive = active.contains(i) && active.contains(i + 1);
      return bothActive
          ? const SolidLineConnector()
          : const DashedLineConnector();
    }

    return FixedTimeline.tileBuilder(
      theme: TimelineThemeData(
        nodePosition: 0.08,
        indicatorTheme: const IndicatorThemeData(size: 18),
        connectorTheme: const ConnectorThemeData(thickness: 2),
        color: cs.outlineVariant,
      ),
      builder: TimelineTileBuilder.connected(
        itemCount: labels.length,
        contentsAlign: ContentsAlign.basic,
        // Texte à droite
        contentsBuilder: (_, i) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            labels[i],
            style: TextStyle(
              fontWeight:
                  active.contains(i) ? FontWeight.w700 : FontWeight.w500,
              color: active.contains(i)
                  ? cs.onSurface
                  : cs.onSurfaceVariant,
            ),
          ),
        ),
        // Indicateurs & connecteurs (widgets)
        indicatorBuilder: (_, i) => indicatorFor(i),
        connectorBuilder: (_, i, __) => connectorFor(i),
      ),
    );
  }
}
