import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../viewmodels/auth/login_view_model.dart';
import 'register_screen.dart';
import 'reset_password_screen.dart';

class LoginScreen extends StatefulWidget {
  final String userType;

  const LoginScreen({super.key, required this.userType});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // ⭐ Inject LoginViewModel
  final LoginViewModel viewModel = Get.put(LoginViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(height: 10),

                  // TOP IMAGE
                  Center(
                    child: Image.asset(
                      'assets/images/login_illustration.png',
                      height: 190,
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // TITLE
                  Text(
                    "Account Log In",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    "Enter your email & password to continue.",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 14),

                  // EMAIL FIELD
                  TextField(
                    controller: viewModel.emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),

                  const SizedBox(height: 12),

                  // PASSWORD FIELD
                  Obx(() {
                    return TextField(
                      controller: viewModel.passwordController,
                      obscureText: !viewModel.isPasswordVisible.value,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            viewModel.isPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            viewModel.isPasswordVisible.value =
                            !viewModel.isPasswordVisible.value;
                          },
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 18),

                  // LOGIN BUTTON (MVVM)
                  Obx(() {
                    return SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        onPressed:
                        viewModel.isLoading.value ? null : viewModel.login,
                        child: viewModel.isLoading.value
                            ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                            : Text(
                          "Login",
                          style: GoogleFonts.poppins(
                            fontSize: 14.5,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 12),

                  // RESET PASSWORD
                  Center(
                    child: GestureDetector(
                      onTap: () => Get.to(() => ResetPasswordScreen()),
                      child: Text(
                        "Forgot Password?",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // REGISTER BUTTON
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => const RegisterScreen(userType: "user"));
                      },
                      child: RichText(
                        text: const TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: "Register here",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
