import 'package:get/get.dart';

// 🔹 BINDINGS
import 'bindings/home_binding.dart';
import 'bindings/service_binding.dart';
import 'bindings/provider_binding.dart';
import 'bindings/auth_binding.dart';
import 'bindings/booking_binding.dart';


// 🔹 COMMON SCREENS
import 'views/common/splash_screen.dart';
import 'views/common/onboarding_screen.dart';
import 'views/common/role_selection_screen.dart';
import 'views/common/provider_list_screen.dart';

// 🔹 AUTH SCREENS
import 'views/auth/login_screen.dart';
import 'views/auth/reset_password_screen.dart';
import 'views/auth/change_password_screen.dart';

// 🔹 CUSTOMER SCREENS
import 'views/customer/home_screen.dart';
import 'views/customer/booking_screen.dart';
import 'views/customer/personal_info_screen.dart';
import 'views/customer/booking_detail_screen.dart';

// 🔹 PROVIDER SCREENS
import 'views/provider/provider_home_screen.dart';

class Routes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const roleSelect = '/roleSelect';

  // 🔐 AUTH
  static const loginUser = '/loginUser';
  static const loginProvider = '/loginProvider';
  static const resetPassword = '/resetPassword';
  static const changePassword = '/changePassword';

  // 👤 CUSTOMER FLOW
  static const home = '/home';
  static const booking = '/booking';
  static const personalInfo = '/personalInfo';
  static const providerList = '/providerList';
  static const bookingDetail = '/bookingDetail';

  // 🧑‍🔧 PROVIDER
  static const providerHome = '/providerHome';
}

class AppPages {
  static final pages = [

    // 🔹 COMMON
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.onboarding,
      page: () => const OnboardingScreen(),
    ),
    GetPage(
      name: Routes.roleSelect,
      page: () => const RoleSelectionScreen(),
    ),

    // 🔐 AUTH
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
      page: () =>  ChangePasswordScreen(),
      binding: AuthBinding(),
    ),

    // 👤 CUSTOMER
    GetPage(
      name: Routes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.booking,
      page: () => const BookingScreen(),
      binding: ServiceBinding(),
    ),
    GetPage(
      name: Routes.personalInfo,
      page: () => const PersonalInfoScreen(),
    ),
    GetPage(
      name: Routes.providerList,
      page: () {
        final args = Get.arguments as Map<String, dynamic>? ?? {};

        return ProviderListScreen(
          name: args['name'] ?? '',
          phone: args['phone'] ?? '',
          address: args['address'] ?? '',
          mainType: args['mainType'] ?? '',
          totalPrice: args['totalPrice'] ?? 0,
          services: args['services'] ?? [],
        );
      },
      binding: ProviderBinding(),
    ),

    GetPage(
      name: Routes.bookingDetail,
      page: () =>  BookingDetailScreen(),
      binding: BookingBinding(),
    ),

    // 🧑‍🔧 PROVIDER
    GetPage(
      name: Routes.providerHome,
      page: () =>  ProviderHomeScreen(),
    ),
  ];
}
