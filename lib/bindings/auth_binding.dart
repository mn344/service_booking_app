import 'package:get/get.dart';

// AUTH VIEWMODELS
import '../../viewmodels/auth/login_view_model.dart';
import '../../viewmodels/auth/register_view_model.dart';
import '../../viewmodels/auth/reset_password_view_model.dart';
import '../../viewmodels/auth/change_password_view_model.dart';
import '../../viewmodels/auth/profile_screen_view_model.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {

    // 🔵 Inject All Auth Related ViewModels
    Get.lazyPut<LoginViewModel>(() => LoginViewModel());
    Get.lazyPut<RegisterViewModel>(() => RegisterViewModel());
    Get.lazyPut<ResetPasswordViewModel>(() => ResetPasswordViewModel());
    Get.lazyPut<ChangePasswordViewModel>(() => ChangePasswordViewModel());
    Get.lazyPut<ProfileScreenViewModel>(() => ProfileScreenViewModel());
  }
}
