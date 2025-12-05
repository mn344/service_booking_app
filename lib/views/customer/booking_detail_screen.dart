import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/views/customer/chat/chat_screen.dart';

class BookingDetailScreen extends StatelessWidget {
  final String userName;
  final String contact;
  final String location;
  final String jobType;
  final String projectLength;

  final String providerName;
  final String providerPrice;
  final String providerRating;
  final String providerImage;

  const BookingDetailScreen({
    super.key,
    required this.userName,
    required this.contact,
    required this.location,
    required this.jobType,
    required this.projectLength,
    required this.providerName,
    required this.providerPrice,
    required this.providerRating,
    required this.providerImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Booking Detail',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),

      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ---------- USER DETAILS ----------
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("User Details",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage:
                        AssetImage('assets/images/user_avatar.jpg'),
                      ),
                      const SizedBox(width: 16),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildText("Name: $userName",
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          const SizedBox(height: 4),
                          _buildText("Phone: $contact",
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          const SizedBox(height: 4),
                          _buildText("Service Type: $jobType",
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          const SizedBox(height: 4),
                          _buildText("Time: $projectLength",
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ],
                      )
                    ],
                  ),

                  const SizedBox(height: 12),
                  _buildText("Address: $location",
                      fontWeight: FontWeight.bold, color: Colors.black),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Booking Information",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 10),

            Column(
              children: [
                _buildProviderRow(),

                _buildBookingRow('Standard Cleaning', '', '₹ 250', '', 0,
                    Icons.cleaning_services),
                _buildBookingRow('Sanitization', '', '₹ 250', '', 0,
                    Icons.cleaning_services),
                _buildBookingRow('Blinds Cleaning', '', '₹ 250', '', 0,
                    Icons.cleaning_services),

                const SizedBox(height: 10),

                _buildBookingRow(
                    'Total', '', providerPrice, '', 0, Icons.attach_money),
              ],
            ),

            const SizedBox(height: 20),


            // ⭐ SUBMIT BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ⭐ CHAT BUTTON (GETX FIXED)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => ChatScreen(
                    providerName: providerName,
                    providerImage: providerImage,
                  ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Chat",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------
  Widget _buildText(String text,
      {FontWeight fontWeight = FontWeight.normal, Color color = Colors.grey}) {
    return Text(
      text,
      style: TextStyle(fontSize: 14, fontWeight: fontWeight, color: color),
    );
  }

  // -------------------------------------------------------
  Widget _buildProviderRow() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),

      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              providerImage,
              height: 45,
              width: 45,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8),

          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildText(providerName,
                    fontWeight: FontWeight.bold, color: Colors.black),
                _buildText("23 April, 2022 11:00 am", color: Colors.black),
              ],
            ),
          ),

          _buildText(providerPrice,
              fontWeight: FontWeight.bold, color: Colors.black),

          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 16),
              Text(providerRating,
                  style: const TextStyle(fontSize: 14, color: Colors.black)),
            ],
          )
        ],
      ),
    );
  }

  // -------------------------------------------------------
  Widget _buildBookingRow(String title, String subtitle, String price,
      String details, double rating, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 8),

          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildText(title,
                    fontWeight: FontWeight.bold, color: Colors.black),
                if (subtitle.isNotEmpty)
                  _buildText(subtitle, color: Colors.black),
                if (details.isNotEmpty)
                  _buildText(details, color: Colors.black),
              ],
            ),
          ),

          _buildText(price, fontWeight: FontWeight.bold, color: Colors.black),
        ],
      ),
    );
  }
}
