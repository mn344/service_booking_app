import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  final String userType; // coming from role selection

  const RegisterScreen({super.key, required this.userType});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool showPassword = false;
  bool showConfirm = false;

  String gender = "Male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new, size: 22),
              ),

              const SizedBox(height: 10),

              // Title
              Text(
                "Create Account",
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                "Join us and unlock a world of possibilities.",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 25),

              // Full Name
              _buildLabel("Name"),
              _buildInputField("Enter your Full Name"),

              const SizedBox(height: 18),

              // Mobile Number
              _buildLabel("Mobile Number"),
              _buildInputField("+92 000 0000000"),

              const SizedBox(height: 18),

              // Email
              _buildLabel("Email Address"),
              _buildInputField("Enter your Email"),

              const SizedBox(height: 18),

              // Gender
              _buildLabel("Gender"),
              Row(
                children: [
                  genderButton("Male"),
                  const SizedBox(width: 10),
                  genderButton("Female"),
                ],
              ),

              const SizedBox(height: 18),

              // Password
              _buildLabel("Password"),
              _buildInputField(
                "•••••",
                isPassword: true,
                showPassword: showPassword,
                onToggle: () {
                  setState(() => showPassword = !showPassword);
                },
              ),

              const SizedBox(height: 18),

              // Confirm Password
              _buildLabel("Confirm Password"),
              _buildInputField(
                "•••••",
                isPassword: true,
                showPassword: showConfirm,
                onToggle: () {
                  setState(() => showConfirm = !showConfirm);
                },
              ),

              const SizedBox(height: 25),

              // SIGNUP BUTTON
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (widget.userType == "provider") {
                      Navigator.pushNamed(context, "/providerHome");
                    } else {
                      Navigator.pushNamed(context, "/home");
                    }
                  },
                  child: Text(
                    "Signup",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Footer
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Already have an account? ",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "Log In",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.blue,
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
    );
  }

  // --------------------
  // CUSTOM WIDGETS BELOW
  // --------------------

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildInputField(
      String hint, {
        String? prefix,
        bool isPassword = false,
        bool showPassword = false,
        VoidCallback? onToggle,
      }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: Colors.blue,
            width: 1.3,
        ),
      ),
      child: Row(
        children: [
          if (prefix != null)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text(prefix, style: const TextStyle(fontSize: 16)),
            ),

          Expanded(
            child: TextField(
              obscureText: isPassword ? !showPassword : false,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
              ),
            ),
          ),

          if (isPassword)
            IconButton(
              onPressed: onToggle,
              icon: Icon(
                showPassword ? Icons.visibility : Icons.visibility_off,
                size: 20,
              ),
            ),
        ],
      ),
    );
  }

  Widget genderButton(String value) {
    bool selected = gender == value;

    return InkWell(
      onTap: () {
        setState(() {
          gender = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? Colors.cyan.withOpacity(0.15) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? Colors.blue : Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.check_circle : Icons.circle_outlined,
              color: selected ? Colors.blue : Colors.grey,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: selected ? Colors.blue : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
