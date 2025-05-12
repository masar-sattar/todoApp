import 'package:flutter/material.dart';

class FieldProfile extends StatelessWidget {
  const FieldProfile(
      {super.key,
      required this.labelText,
      required this.lableTitle,
      this.trailing});
  final String labelText;
  final String lableTitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 90,
        width: 340,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromARGB(255, 248, 247, 247),
          border: Border.all(
            color: const Color.fromARGB(255, 247, 243, 243),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 250),
          child: Column(

            children: [
              Text(
                labelText,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                lableTitle,
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
