import 'package:get/get.dart';

// COMMON SCREENS
import 'views/common/splash_screen.dart';
import 'views/common/onboarding_screen.dart';
import 'views/common/role_selection_screen.dart';

// CUSTOMER SCREENS
import 'views/customer/home_screen.dart';
import 'views/customer/personal_info_screen.dart';
import 'views/customer/booking_detail_screen.dart';

// PROVIDER SCREENS
import 'views/provider/provider_home_screen.dart';
import 'views/provider/provider_job_detail_screen.dart';

// AUTH SCREENS
import 'package:service_booking_app/views/auth/login_screen.dart';
import 'package:service_booking_app/views/auth/reset_password_screen.dart';
import 'package:service_booking_app/views/auth/change_password_screen.dart';

// BINDINGS
import 'package:service_booking_app/bindings/auth_binding.dart';

class Routes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const roleSelect = '/roleSelect';
  static const loginUser = '/loginUser';
  static const loginProvider = '/loginProvider';
  static const resetPassword = '/resetPassword';
  static const changePassword = '/changePassword';
  static const home = '/home';
  static const personalInfo = '/personalInfo';
  static const providerHome = '/providerHome';
}

class AppPages {
  static final pages = [
    /// Common Screens
    GetPage(
      name: Routes.splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: Routes.onboarding,
      page: () => OnboardingScreen(),
    ),
    GetPage(
      name: Routes.roleSelect,
      page: () => RoleSelectionScreen(),
    ),

    /// Auth Screens (Binding Required)
    GetPage(
      name: Routes.loginUser,
      page: () => LoginScreen(userType: "user"),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.loginProvider,
      page: () => LoginScreen(userType: "provider"),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.resetPassword,
      page: () => ResetPasswordScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.changePassword,
      page: () => ChangePasswordScreen(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),

    /// Customer Screens
    GetPage(
      name: Routes.home,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: Routes.personalInfo,
      page: () => PersonalInfoScreen(),
    ),

    /// Provider Screens
    GetPage(
      name: Routes.providerHome,
      page: () => ProviderHomeScreen(),
    ),
  ];
}
