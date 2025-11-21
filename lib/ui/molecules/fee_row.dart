import 'package:flutter/material.dart';
import '../atoms/fee_text.dart';

class FeeRow extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;

  const FeeRow({super.key, required this.label, required this.value, this.highlight = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FeeText(label, color: highlight ? Colors.black : Colors.grey),
          FeeText(value, isBold: true, color: highlight ? Colors.green : Colors.black87, fontSize: highlight ? 16 : 14),
        ],
      ),
    );
  }
}