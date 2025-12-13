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

  final LoginViewModel viewModel = Get.find<LoginViewModel>();


  // ✅ Controllers ONLY in UI
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 450),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(height: 10),

                    Center(
                      child: Image.asset(
                        'assets/images/login_illustration.png',
                        height: 190,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Account Log In",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    Text(
                      "Enter your email & password to continue.",
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        color: Colors.black54,
                      ),
                    ),

                    const SizedBox(height: 14),

                    // EMAIL
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                    ),

                    const SizedBox(height: 12),

                    // PASSWORD
                    Obx(() {
                      return TextField(
                        controller: passwordController,
                        obscureText: !viewModel.isPasswordVisible.value,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              viewModel.isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              viewModel.isPasswordVisible.toggle();
                            },
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 18),

                    // ✅ LOGIN BUTTON (CORRECT)
                    Obx(() {
                      return SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: ElevatedButton(
                          onPressed: viewModel.isLoading.value
                              ? null
                              : () async {
                            try {
                              // 🔹 Call ViewModel
                              final role = await viewModel.login(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );

                              // 🔹 Navigation in VIEW
                              if (role == 'provider') {
                                Get.offAllNamed('/providerHome');
                              } else {
                                Get.offAllNamed('/home');
                              }

                            } catch (e) {
                              Get.snackbar(
                                "Login Failed",
                                e.toString(),
                              );
                            }
                          },
                          child: viewModel.isLoading.value
                              ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                              : const Text("Login"),
                        ),
                      );
                    }),

                    const SizedBox(height: 12),

                    Center(
                      child: GestureDetector(
                        onTap: () =>
                            Get.to(() =>  ResetPasswordScreen()),
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),

                    Center(
                      child: TextButton(
                        onPressed: () {
                          Get.to(() =>
                              RegisterScreen(userType: widget.userType));
                        },
                        child: const Text(
                          "Don't have an account? Register",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
