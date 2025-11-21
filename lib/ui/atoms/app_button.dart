import 'package:flutter/material.dart';

/// Reusable Button Component.
/// Standardizes button styling across the application (Height, Elevation, Colors).
class AppButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final Color? backgroundColor;

  const AppButton({
    super.key, 
    required this.label, 
    required this.icon, 
    required this.onPressed,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56, // Fixed height for touch targets
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          elevation: 0, // Flat design
        ),
      ),
    );
  }
}