import 'package:flutter/material.dart';

import '../widget/field_profile.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FieldProfile(labelText: 'Name', lableTitle: 'islam syad'),
            SizedBox(height: 10),
            FieldProfile(
              labelText: 'Phone',
              lableTitle: '0773224555',
              trailing: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 300),
                child: Icon(
                  Icons.copy,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            SizedBox(height: 10),
            FieldProfile(labelText: 'Level', lableTitle: 'senior'),
            SizedBox(height: 10),
            FieldProfile(
                labelText: 'Years of Experience', lableTitle: '7 years'),
            SizedBox(height: 10),
            FieldProfile(labelText: 'Location', lableTitle: 'fayyum,Egypt')
          ],
        ),
      ),
    );
  }
}
