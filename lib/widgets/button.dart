import 'package:flutter/material.dart';

class BUTTON extends StatelessWidget {
  const BUTTON({
    super.key,
    required this.bg_color,
    required this.fg_color,
    required this.title,
    required this.onPressed,
    this.opacity = 1.0, // Default to fully opaque
  });

  final Color bg_color;
  final Color fg_color;
  final String title;
  final VoidCallback onPressed;
  final double opacity; // Parameter to adjust button background transparency

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          backgroundColor: bg_color.withOpacity(opacity), // Apply opacity to background
          foregroundColor: fg_color, // Keep the text color fully opaque
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Rounded corners
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
