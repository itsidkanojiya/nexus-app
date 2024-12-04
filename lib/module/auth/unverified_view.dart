import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class UnverifiedView extends StatelessWidget {
  const UnverifiedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Verification"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 250, child: Lottie.asset('assets/unauthorized.json')),
            const Text(
              'Your account is not verified.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle verification process (e.g., send verification email)
              },
              child: const Text('Verify Now'),
            ),
          ],
        ),
      ),
    );
  }
}
