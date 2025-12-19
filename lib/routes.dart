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
import 'views/auth/register_screen.dart';
import 'views/auth/reset_password_screen.dart';
import 'views/auth/change_password_screen.dart';

// 🔹 CUSTOMER SCREENS
import 'views/customer/home_screen.dart';
import 'views/customer/booking_screen.dart';
import 'views/customer/personal_info_screen.dart';
import 'views/customer/booking_detail_screen.dart';

// 🔹 PROVIDER SCREENS
import 'views/provider/provider_home_screen.dart';
import 'views/provider/provider_manage_services_screen.dart';
import 'views/provider/provider_add_update_service_screen.dart';
import 'bindings/provider_service_binding.dart';


class Routes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const roleSelect = '/roleSelect';

  // 🔐 AUTH
  static const loginUser = '/loginUser';
  static const loginProvider = '/loginProvider';
  static const register = '/register';
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
  static const providerManageServices = '/providerManageServices';
  static const providerAddUpdateServices = '/providerAddUpdateServices';
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
      name: Routes.register,
      page: () => RegisterScreen(userType: Get.arguments),
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
      page: () => ProviderListScreen(),
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

    GetPage(
      name: Routes.providerManageServices,
      page: () => const ProviderManageServicesScreen(),
      binding: ProviderServiceBinding(),
    ),

    GetPage(
      name: Routes.providerAddUpdateServices,
      page: () => const AddUpdateServiceScreen(),
    ),
  ];
}
