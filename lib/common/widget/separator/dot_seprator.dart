// met ça dans un fichier utils/widgets/dots_separator.dart
import 'package:flutter/material.dart';

class DotsSeparator extends StatelessWidget {
  const DotsSeparator({super.key, this.dotSize = 2, this.gap = 6, this.color});
  final double dotSize;
  final double gap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = color ?? Theme.of(context).colorScheme.outline;
    return LayoutBuilder(
      builder: (_, constraints) {
        final count = (constraints.maxWidth / (dotSize + gap)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            count,
            (_) => Container(
              width: dotSize,
              height: dotSize,
              decoration: BoxDecoration(color: c, shape: BoxShape.circle),
            ),
          ),
        );
      },
    );
  }
}
