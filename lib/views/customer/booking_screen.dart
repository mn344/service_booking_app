import 'package:flutter/material.dart';
import 'package:get/get.dart'; // ← ADD THIS
import 'package:google_fonts/google_fonts.dart';
import 'package:service_booking_app/views/customer/personal_info_screen.dart';

class BookingScreen extends StatefulWidget {
  final String serviceName;

  const BookingScreen({super.key, required this.serviceName});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  List<int> selectedIndexes = [];

  final List<Map<String, dynamic>> categories = [
    {"icon": Icons.cleaning_services, "name": "Standard Cleaning"},
    {"icon": Icons.cleaning_services_outlined, "name": "Deep Cleaning"},
    {"icon": Icons.local_shipping, "name": "Moving Cleaning"},
    {"icon": Icons.sanitizer, "name": "Sanitization"},
    {"icon": Icons.blinds, "name": "Blinds Cleaning"},
    {"icon": Icons.curtains, "name": "Curtains Cleaning"},
    {"icon": Icons.clean_hands, "name": "Floor Cleaning"},
    {"icon": Icons.fireplace, "name": "Chimney Sweeping"},
    {"icon": Icons.bathroom, "name": "Bathroom Cleaning"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              decoration: const BoxDecoration(
                color: Color(0xff03A9F4),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),  // ← REPLACED
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    "Categories",
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Choose your preferred service",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // SEARCH BAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 10),
                    Text(
                      "Search",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // GRID
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  itemCount: categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 0.78,
                  ),
                  itemBuilder: (context, index) {
                    final item = categories[index];
                    final bool isSelected = selectedIndexes.contains(index);

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedIndexes.remove(index);
                          } else {
                            selectedIndexes.add(index);
                          }
                        });
                      },

                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xff01579B) : Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 6,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              item["icon"],
                              size: 36,
                              color: isSelected ? Colors.white : const Color(0xff03A9F4),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item["name"],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: isSelected ? Colors.white : Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // NEXT BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: selectedIndexes.isEmpty
                      ? null
                      : () {
                    Get.to(() => const PersonalInfoScreen()); // ← REPLACED WITH GETX
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF03A9F4),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ).copyWith(
                    overlayColor: MaterialStateProperty.all(
                      const Color(0xff01579B).withOpacity(0.3),
                    ),
                    backgroundColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return const Color(0xff01579B);
                      }
                      return const Color(0xFF03A9F4);
                    }),
                  ),

                  child: Text(
                    "Next",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
