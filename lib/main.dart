import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

// ROUTES
import 'routes.dart'; // We'll handle all routes in one file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Service Booking App",

      // ⭐ Using GetX named routes
      initialRoute: Routes.splash,

      getPages: AppPages.pages,  // Pass the pages list from AppPages

      // Optional theme
      // theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
