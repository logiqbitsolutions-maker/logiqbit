import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/modules/home/bindings/home_binding.dart';
import 'app/modules/home/views/home_view.dart';
import 'core/theme/app_theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const LogiqbitApp());
}

class LogiqbitApp extends StatelessWidget {
  const LogiqbitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Logiqbit Solutions',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const HomeView(),
          binding: HomeBinding(),
        ),
      ],
    );
  }
}
