import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _scaleAnim;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _scaleAnim = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.elasticOut),
    );

    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeIn);

    _animController.forward();

    Timer(const Duration(seconds: 3), () {
      Get.offNamed('/onboarding'); // ✅ Go to onboarding screen
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // gradient background for better look
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0B3D91), // deep
              Color(0xFF1366D6), // light
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: ScaleTransition(
                scale: _scaleAnim,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Stylish RichText "CleanX"
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          // fallback defaults
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: 'Clean',
                            style: GoogleFonts.poppins(
                              fontSize: 44,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.4,
                              // subtle shadow via foreground is not available directly;
                              // using shadows in TextStyle:
                              shadows: [
                                Shadow(
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                  color: Colors.black26,
                                ),
                              ],
                            ),
                          ),
                          TextSpan(
                            text: 'X',
                            style: GoogleFonts.bebasNeue(
                              fontSize: 54,
                              letterSpacing: 2,
                              color: Colors.cyanAccent,
                              shadows: [
                                Shadow(
                                  blurRadius: 8,
                                  offset: Offset(0, 3),
                                  color: Colors.black26,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // subtitle
                    Text(
                      'Service Booking App',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white70,
                        letterSpacing: 0.6,
                      ),
                    ),

                    const SizedBox(height: 26),

                    // subtle loading indicator
                    const SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
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
