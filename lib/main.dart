import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nexus_app/module/auth/splash/splash_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(NexusApp());
}

class NexusApp extends StatelessWidget {
  NexusApp({super.key});
  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return SafeAreaWrapper(
      child: GetMaterialApp(
          builder: EasyLoading.init(),
          debugShowCheckedModeBanner: false,
          title: 'Nexus App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromRGBO(119, 173, 163, 1)),
            useMaterial3: true,
          ),
          home: SplashView()),
    );
  }
}

class SafeAreaWrapper extends StatelessWidget {
  final Widget child;

  const SafeAreaWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: child);
  }
}
