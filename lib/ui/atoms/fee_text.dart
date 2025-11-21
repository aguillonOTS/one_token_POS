import 'package:flutter/material.dart';

/// Atomic Text Component.
/// Used for labels and standard text to ensure typographic consistency.
class FeeText extends StatelessWidget {
  final String text;
  final bool isBold;
  final Color? color;
  final double fontSize;

  const FeeText(this.text, {super.key, this.isBold = false, this.color, this.fontSize = 14});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: color ?? Colors.black87,
        fontSize: fontSize,
      ),
    );
  }
}