import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BlaButton Test')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlaButton(
              label: 'Contact Volodia',
              icon: Icons.contact_mail,
              isPrimary: true,
              onPressed: () {
                print('Contact Volodia pressed!');
              },
            ),
            SizedBox(height: 20),
            BlaButton(
              label: 'Request to Book',
              isPrimary: false,
              onPressed: () {
                print('Request to Book pressed!');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BlaButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool isPrimary;
  final VoidCallback onPressed;

  BlaButton({
    required this.label,
    this.icon,
    required this.isPrimary,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: icon != null ? Icon(icon) : Container(),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? Colors.blue : Colors.grey,
      ),
      onPressed: onPressed,
    );
  }
}

void main() {
  runApp(MaterialApp(home: TestScreen()));
}