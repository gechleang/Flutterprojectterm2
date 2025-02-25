import 'package:flutter/material.dart';

class BlaButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool isPrimary;
  final VoidCallback onPressed;

  const BlaButton({
    Key? key,
    required this.label,
    this.icon,
    this.isPrimary = true,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon != null ? Icon(icon) : SizedBox.shrink(),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? Colors.blue : Colors.grey, // Change colors based on isPrimary
      ),
    );
  }
}