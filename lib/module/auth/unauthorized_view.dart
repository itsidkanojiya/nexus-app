import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class UnauthorizedView extends StatelessWidget {
  const UnauthorizedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Unauthorized Access"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 250, child: Lottie.asset('assets/unauthorized.json')),
            const Text(
              'You do not have permission to access this page.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.back(); // Navigate back to the previous screen
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
