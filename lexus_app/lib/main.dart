import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lexus_app/module/home/home_page.dart';
import 'package:lexus_app/theme/style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) {
        return const NexusApp();
      },
    ),
  );
}

class NexusApp extends StatelessWidget {
  const NexusApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lexus App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Style.primary),
          useMaterial3: true,
        ),
        home: HomeView());
  }
}
