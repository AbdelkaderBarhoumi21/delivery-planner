import 'package:flutter/material.dart';

class AppOrderChoice extends StatelessWidget {
  const AppOrderChoice({
    super.key,
    required this.theme,
    required this.chosenNames,
  });

  final ThemeData theme;
  final List<String> chosenNames;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          hintStyle: theme.textTheme.labelMedium,
          hintText: chosenNames.isEmpty
              ? 'Tap to choose orders'
              : chosenNames.join(', '),
          prefixIcon: const Icon(Icons.receipt_long_outlined),
          suffixIcon: const Icon(Icons.expand_more),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}