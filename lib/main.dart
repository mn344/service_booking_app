import 'package:flutter/material.dart';

// COMMON SCREENS
import 'views/common/splash_screen.dart';
import 'views/common/onboarding_screen.dart';
import 'views/common/role_selection_screen.dart';
import 'views/common/provider_list_screen.dart';

// CUSTOMER SCREENS
import 'views/customer/home_screen.dart';
import 'views/customer/personal_info_screen.dart';
import 'views/customer/booking_detail_screen.dart';

// PROVIDER SCREENS
import 'views/provider/provider_home_screen.dart';   // ✅ NEW IMPORT

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Service Booking App",

      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/roleSelect': (context) => const RoleSelectionScreen(),
        '/home': (context) => const HomeScreen(),
        '/personalInfo': (context) => const PersonalInfoScreen(),

        // ✅ NEW ROUTE FOR PROVIDER
        '/providerHome': (context) => ProviderHomeScreen(),
      },

      home: const SplashScreen(),
    );
  }
}
