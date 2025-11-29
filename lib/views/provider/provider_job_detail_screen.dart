import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProviderJobDetailScreen extends StatelessWidget {
  const ProviderJobDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: Text(
          "Job Detail",
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.notifications_none, color: Colors.blue),
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ------------------ DETAILS CARD --------------------
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _detailRow("Name", "Abhishek Jain"),
                  const SizedBox(height: 8),
                  _detailRow("Address",
                      "Dhakkan Wala Kua, Trade House, 214-215, S Tukoganj Rd, Indore"),
                  const SizedBox(height: 8),
                  _detailRow("Phone", "+91 98266 98050"),
                  const SizedBox(height: 8),
                  _detailRow("Time", "2 Hrs"),
                  const SizedBox(height: 8),
                  _detailRow("Service Type", "Home Cleaner"),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ---------------- PROVIDER CARD ---------------------
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 6,
                      offset: const Offset(0, 2))
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Provider Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      "assets/images/user_avatar.jpg",
                      height: 65,
                      width: 65,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Name + Address + Date
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("John Doe",
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        Text(
                          "Dhakkan Wala Kua, Trade House,\n214-215, S Tukoganj Road, Indore",
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: Colors.black54),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "23 April, 2022 11:00 am",
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: Colors.blue),
                        ),
                      ],
                    ),
                  ),

                  // Price + Status
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("₹ 800",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 6),
                      Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Completed",
                          style: GoogleFonts.poppins(
                              color: Colors.green, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ---------------- SERVICE ITEMS ---------------------
            _serviceTile(Icons.cleaning_services,
                "Standard Cleaning", "Residential Cleaning", "₹250"),

            _serviceTile(Icons.sanitizer,
                "Sanitization", "Residential Cleaning", "₹250"),

            _serviceTile(Icons.window,
                "Blinds Cleaning", "Residential Cleaning", "₹250"),

            const SizedBox(height: 10),

            // ---------------- PRICE SECTION ---------------------
            _priceRow("Service Charge:", "₹100"),
            _priceRow("Discount:", "- ₹50"),
            const Divider(),
            _priceRow("Total:", "₹800", isBold: true),

            const SizedBox(height: 25),

            // ---------------- TRACK BUTTON ---------------------
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff1F1C47),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {},
                child: Text(
                  "Track Button",
                  style: GoogleFonts.poppins(
                      color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ---------------- BOTTOM 2 BUTTONS ---------------------
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {},
                    child: Text("Chat",
                        style: GoogleFonts.poppins(
                            color: Colors.white,fontSize: 15, fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {},
                    child: Text("Start Job",
                        style: GoogleFonts.poppins(
                            color: Colors.white,fontSize: 15, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ---------------------- WIDGETS ----------------------------

  Widget _detailRow(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: 110,
            child: Text("$title:",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: 13))),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.poppins(fontSize: 13),
          ),
        ),
      ],
    );
  }

  Widget _serviceTile(
      IconData icon, String title, String subtitle, String price) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 36,
            color: const Color(0xff1F1C47), // Header color
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w600)),
                Text(subtitle,
                    style: GoogleFonts.poppins(
                        fontSize: 12, color: Colors.black54)),
              ],
            ),
          ),

          Text(price,
              style: GoogleFonts.poppins(
                  fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _priceRow(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: isBold ? FontWeight.w700 : FontWeight.w500)),
          Text(value,
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: isBold ? FontWeight.w700 : FontWeight.w500)),
        ],
      ),
    );
  }
}
