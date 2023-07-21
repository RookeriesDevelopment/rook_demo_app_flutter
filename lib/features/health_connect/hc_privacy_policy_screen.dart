import 'package:flutter/material.dart';

class HCPrivacyPolicyScreen extends StatelessWidget {
  const HCPrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy policy')),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: const Column(
          children: [
            Text('This is a placeholder example.'),
            SizedBox(height: 10),
            Text(
              'Your app should display an appropriate privacy policy for how you will handle and use Health Connect data.',
            ),
            SizedBox(height: 10),
            Text(
              'This sample app does not store or transmit any data outside of Health Connect.',
            ),
          ],
        ),
      ),
    );
  }
}
