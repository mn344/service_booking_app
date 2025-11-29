import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../auth/login_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF24146B),
      body: Column(
        children: [
          const SizedBox(height: 150),

          // ----------- CleanX Logo -----------
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Clean",
                  style: GoogleFonts.poppins(
                    fontSize: 42,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: "X",
                  style: GoogleFonts.bebasNeue(
                    fontSize: 50,
                    color: Colors.cyanAccent,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          // ---------- White Container ----------
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45),
                topRight: Radius.circular(45),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ----------- Greeting Text -----------
                Row(
                  children: [
                    Text(
                      "Hello! ",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text("👋", style: TextStyle(fontSize: 22)),
                  ],
                ),
                const SizedBox(height: 5),

                // ----------- RichText -----------
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      color: Colors.black87,
                      fontSize: 18,
                    ),
                    children: const [
                      TextSpan(text: "Which You Like To "),
                      TextSpan(
                        text: "Enter As?",
                        style: TextStyle(
                          color: Colors.cyan,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // ---------------- Buttons Row ----------------
                Row(
                  children: [
                    // ⭐ USER BUTTON
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2D226A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const LoginScreen(userType: "user"),
                            ),
                          );
                        },
                        child: Text(
                          "As User",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 15),

                    // ⭐ PROVIDER BUTTON
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00CFFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const LoginScreen(userType: "provider"),
                            ),
                          );
                        },
                        child: Text(
                          "As Provider",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Footer Text
                Center(
                  child: Text(
                    "Please Choose One ☝️ Of The Options Above",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
