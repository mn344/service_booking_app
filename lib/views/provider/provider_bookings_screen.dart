import 'package:flutter/material.dart';

class ProviderBookingsScreen extends StatefulWidget {
  const ProviderBookingsScreen({super.key});

  @override
  State<ProviderBookingsScreen> createState() =>
      _ProviderBookingsScreenState();
}

class _ProviderBookingsScreenState extends State<ProviderBookingsScreen> {
  int selectedTab = 0; // 0-All, 1-Active, 2-Cancelled, 3-Completed

  // 🔹 Dummy booking list
  final List<Map<String, dynamic>> bookings = [
    {
      "name": "Alexa Johan",
      "image": "assets/images/bathroom_cleaner.png",
      "price": "800",
      "date": "23 Apr, 2022 | 11:00 am",
      "status": "Completed",
      "rating": "4.3",
    },
    {
      "name": "John Jain",
      "image": "assets/images/chimny_cleaner.png",
      "price": "800",
      "date": "23 Apr, 2022 | 11:00 am",
      "status": "Cancelled",
      "rating": "4.3",
    },
    {
      "name": "Usama Ahmed",
      "image": "assets/images/sofa_cleaner.png",
      "price": "800",
      "date": "23 Apr, 2022 | 11:00 am",
      "status": "Completed",
      "rating": "4.3",
    },
    {
      "name": "Abdul Rehman",
      "image": "assets/images/deep_cleaner.png",
      "price": "800",
      "date": "23 Apr, 2022 | 11:00 am",
      "status": "Active",
      "rating": "4.3",
    },
    {
      "name": "Jatin Sharma",
      "image": "assets/images/user_avatar.jpg",
      "price": "800",
      "date": "23 Apr, 2022 | 11:00 am",
      "status": "Cancelled",
      "rating": "4.3",
    },
  ];

  // 🔹 Status Color
  Color getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return Colors.green;
      case "Cancelled":
        return Colors.red;
      case "Active":
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  // 🔹 Filter Bookings According to Tab
  List<Map<String, dynamic>> get filteredBookings {
    if (selectedTab == 0) return bookings;
    if (selectedTab == 1) {
      return bookings.where((b) => b["status"] == "Active").toList();
    }
    if (selectedTab == 2) {
      return bookings.where((b) => b["status"] == "Cancelled").toList();
    }
    if (selectedTab == 3) {
      return bookings.where((b) => b["status"] == "Completed").toList();
    }
    return bookings;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "My Bookings",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: Column(
        children: [
          const SizedBox(height: 10),

          // 🔹 Tabs
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              tabItem("All", 0),
              tabItem("Active", 1),
              tabItem("Cancelled", 2),
              tabItem("Completed", 3),
            ],
          ),

          const SizedBox(height: 10),

          // 🔹 Booking List
          Expanded(
            child: ListView.builder(
              itemCount: filteredBookings.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, index) {
                final booking = filteredBookings[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xffF8F8F8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          booking["image"],
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              booking["name"],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              booking["date"],
                              style:
                              const TextStyle(fontSize: 13, color: Colors.grey),
                            ),
                            const SizedBox(height: 7),

                            Row(
                              children: [
                                Text(
                                  "₹ ${booking["price"]}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                const SizedBox(width: 10),

                                // Status Badge
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: getStatusColor(booking["status"])
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    booking["status"],
                                    style: TextStyle(
                                      color: getStatusColor(booking["status"]),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),

                      // Rating + Delete
                      Column(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          Text(
                            booking["rating"],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          const Icon(Icons.delete, color: Colors.red),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Tab Widget
  Widget tabItem(String title, int index) {
    final isSelected = selectedTab == index;

    return GestureDetector(
      onTap: () => setState(() => selectedTab = index),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }
}
