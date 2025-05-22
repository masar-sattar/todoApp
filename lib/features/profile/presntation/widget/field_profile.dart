import 'package:flutter/material.dart';

class FieldProfile extends StatelessWidget {
  const FieldProfile({
    super.key,
    required this.labelText,
    required this.lableTitle,
    this.trailing,
  });

  final String labelText;
  final String lableTitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF8F7F7),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFF7F3F3),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Expanded Texts (label + value)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    labelText,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    lableTitle,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            // Trailing Icon (copy or any other)
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
