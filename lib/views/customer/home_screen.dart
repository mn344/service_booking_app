import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'booking_screen.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/views/auth/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:service_booking_app/routes.dart';
import 'package:service_booking_app/views/auth/change_password_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ---------------- ADD DRAWER ----------------
      drawer: _buildDrawer(context),

      body: SafeArea(
        child: Column(
          children: [
            // ---------------- HEADER ----------------
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xff06BEE1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ---------------- MENU ICON FIXED ----------------
                      Builder(
                        builder: (context) => GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: const Icon(Icons.menu,
                              color: Colors.white, size: 26),
                        ),
                      ),

                      const Icon(Icons.notifications_none,
                          color: Colors.white, size: 24),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Text(
                    "Hello Maham",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "How can we help?",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ---------------- SEARCH BAR ----------------
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 11),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.black54, size: 20),
                  const SizedBox(width: 10),
                  Text(
                    "Search Service Type",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ---------------- GRID ----------------
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      childAspectRatio: 1.25,
                    ),
                    itemBuilder: (context, index) {
                      return _serviceCard(
                        index: index,
                        title: titles[index],
                        icon: icons[index],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- SERVICE CARD ----------------
  Widget _serviceCard({
    required int index,
    required String title,
    required IconData icon,
  }) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() => selectedIndex = index);

        Future.delayed(const Duration(milliseconds: 150), () {
          Get.to(() => BookingScreen(serviceName: title))?.then((_) {
            setState(() => selectedIndex = -1);
          });
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0A3D62) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 34,
              color: isSelected ? Colors.white : Colors.black87,
            ),
            const SizedBox(height: 18),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Icon(
                Icons.arrow_forward,
                size: 20,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // -------------------------- BEAUTIFUL DRAWER ------------------------------
  // --------------------------------------------------------------------------

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ---------------- HEADER ----------------
          Container(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
            decoration: const BoxDecoration(
              color: Color(0xff06BEE1),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage:
                    AssetImage("assets/images/chimny_cleaner.png"),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Maham Fatima",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "mahamzaman364@gmail.com",
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ---------------- MENU ITEMS ----------------
          Expanded(
            child: ListView(
              children: [
                _drawerTile(
                  icon: Icons.person_outline,
                  text: "Profile",
                  onTap: () {
                    Navigator.pop(context);
                    Get.to(() =>  ProfileScreen());
                  },
                ),
                _drawerTile(
                    icon: Icons.settings_outlined,
                    text: "Settings",
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                      Get.to(() => ChangePasswordScreen());
                    }),
                _drawerTile(
                    icon: Icons.dark_mode_outlined,
                    text: "Dark Mode",
                    onTap: () {}),
                _drawerTile(
                    icon: Icons.info_outline,
                    text: "About App",
                    onTap: () {}),

                const SizedBox(height: 40),

                _drawerTile(
                  icon: Icons.logout,
                  text: "Logout",
                  color: Colors.red,
                  onTap: () => _showLogoutDialog(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- Drawer Tile ----------------
  Widget _drawerTile({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    Color color = Colors.black,
  }) {
    return ListTile(
      leading: Icon(icon, size: 24, color: color),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }

  // ---------------- Logout Dialog ----------------
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text("Logout"),
          content:
          const Text("Are you sure you want to log out from your account?"),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.lightBlue, // Set the background color
              ),
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              style:
              ElevatedButton.styleFrom(foregroundColor: Colors.white,backgroundColor: Colors.blue),
              child: const Text("Logout"),
              onPressed: () {
                Navigator.pop(context);
                FirebaseAuth.instance.signOut();  // Firebase logout
                Get.offAllNamed(Routes.loginUser);// Add Firebase logout here later//
              },
            ),
          ],
        );
      },
    );
  }
}

List<String> titles = [
  "Residential Cleaning Services",
  "Commercial Cleaning Services",
  "Janitorial Services",
  "Laundry Services",
];

List<IconData> icons = [
  Icons.house_rounded,
  Icons.apartment_rounded,
  Icons.cleaning_services_rounded,
  Icons.local_laundry_service_rounded,
];
