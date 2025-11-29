import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_booking_app/views/customer/booking_detail_screen.dart';

class ProviderListScreen extends StatefulWidget {
  final String userName;
  final String contact;
  final String location;
  final String jobType;
  final String projectLength;

  const ProviderListScreen({
    super.key,
    required this.userName,
    required this.contact,
    required this.location,
    required this.jobType,
    required this.projectLength,
  });

  @override
  State<ProviderListScreen> createState() => _ProviderListScreenState();
}

class _ProviderListScreenState extends State<ProviderListScreen> {
  int? selectedIndex;

  // Provider list
  final List<Map<String, dynamic>> providers = [
    {
      "name": "Sofa Cleaning Expert",
      "price": "₹ 800",
      "rating": "4.3",
      "img": "assets/images/sofa_cleaner.png"
    },
    {
      "name": "Deep Cleaning Service",
      "price": "₹ 950",
      "rating": "4.5",
      "img": "assets/images/deep_cleaner.png"
    },
    {
      "name": "Bathroom Cleaner",
      "price": "₹ 700",
      "rating": "4.2",
      "img": "assets/images/bathroom_cleaner.png"
    },
    {
      "name": "Chimney Cleaner",
      "price": "₹ 850",
      "rating": "4.4",
      "img": "assets/images/chimny_cleaner.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ---------------- APPBAR ----------------
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text(
          "Provider List",
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      // -------------------------------------------------

      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: providers.length,
        itemBuilder: (context, index) {
          final provider = providers[index];
          bool isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue.shade50 : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.grey.shade300,
                  width: 2,
                ),
                boxShadow: const [
                  BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 5,
                    color: Colors.black12,
                    offset: Offset(1, 2),
                  ),
                ],
              ),

              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      provider["img"],
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider["name"],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          "23 April, 2022 11:00 am",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Row(
                          children: [
                            Text(
                              provider["price"],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            const Spacer(),
                            const Icon(Icons.star,
                                color: Colors.amber, size: 18),
                            Text(
                              provider["rating"],
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: selectedIndex == null
              ? null
              : () {
            final selected = providers[selectedIndex!];

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BookingDetailScreen(
                  userName: widget.userName,
                  contact: widget.contact,
                  location: widget.location,
                  jobType: widget.jobType,
                  projectLength: widget.projectLength,

                  providerName: selected["name"],
                  providerPrice: selected["price"],
                  providerRating: selected["rating"],
                  providerImage: selected["img"],
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
            selectedIndex == null ? Colors.grey : Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            "NEXT",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
