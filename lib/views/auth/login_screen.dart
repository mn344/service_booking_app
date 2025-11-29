import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../auth/register_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  final String userType; // user or provider

  const LoginScreen({
    super.key,
    required this.userType,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;

  late FToast fToast;   // Toast object

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);   // initialize toast
  }

  //  Custom Rounded Toast
  void showRoundToast() {
    fToast.showToast(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(30),  // round corners
        ),
        child: const Text(
          "Login Successful",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
      gravity: ToastGravity.BOTTOM,       // Bottom Center
      toastDuration: const Duration(seconds: 2),
    );
  }

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

                  /// TOP IMAGE
                  Center(
                    child: Image.asset(
                      'assets/images/login_illustration.png',
                      height: 190,
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// TITLE
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
                    "Enter your registered phone number or Email Id to Login.",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      color: Colors.black54,
                      height: 1.25,
                    ),
                  ),

                  const SizedBox(height: 14),

                  Text(
                    "Phone number or email",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 3),

                  // PHONE / EMAIL TEXTFIELD
                  Container(
                    height: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blueAccent.shade100),
                    ),
                    child: Center(
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: "+92 000 0000000 or email",
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 12.5,
                            color: Colors.grey,
                          ),
                          prefixIcon: const Icon(Icons.person_outline, color: Colors.blue),
                          suffixIcon: const Icon(Icons.email_outlined, color: Colors.blue),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// PASSWORD LABEL
                  Text(
                    "Password",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 3),

                  /// PASSWORD FIELD
                  Container(
                    height: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blueAccent.shade100),
                    ),
                    child: Center(
                      child: TextField(
                        obscureText: _obscurePassword,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: "••••••",
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 15,
                            letterSpacing: 2.5,
                            color: Colors.grey,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_off : Icons.visibility,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  /// LOGIN BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      onPressed: () {
                        showRoundToast();   // ⭐ Show rounded toast

                        Future.delayed(const Duration(milliseconds: 300), () {
                          if (widget.userType == "provider") {
                            Navigator.pushNamed(context, '/providerHome');
                          } else {
                            Navigator.pushNamed(context, '/home');
                          }
                        });
                      },
                      child: Text(
                        "Login",
                        style: GoogleFonts.poppins(
                          fontSize: 14.5,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// REGISTER REDIRECTION
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an Account? ",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.black87,
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RegisterScreen(
                                  userType: widget.userType,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "Register",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
