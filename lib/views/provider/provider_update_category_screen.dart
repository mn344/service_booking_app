import 'package:flutter/material.dart';

class ProviderUpdateCategoryScreen extends StatefulWidget {
  const ProviderUpdateCategoryScreen({super.key});

  @override
  State<ProviderUpdateCategoryScreen> createState() =>
      _ProviderUpdateCategoryScreenState();
}

class _ProviderUpdateCategoryScreenState
    extends State<ProviderUpdateCategoryScreen> {

  // ---------------- CHECKBOX STATES (All false initially) ----------------
  bool standardCleaning = false;
  bool floorCleaning = false;
  bool deepCleaning = false;
  bool movingCleaning = false;
  bool bathroomCleaning = false;

  bool officeCleaning = false;
  bool sportsCleaning = false;
  bool windowCleaning = false;
  bool windowCleaning2 = false;
  bool medicalCleaning = false;

  bool submitPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Add & Update Category",
          style: TextStyle(
            color: Color(0xFF2A2D52),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // ---------------- RESIDENTIAL CLEANING ----------------
            _buildCategoryCard(
              "Residential Cleaning",
              [
                _buildCheckbox("Standard Cleaning", standardCleaning,
                        (v) => setState(() => standardCleaning = v!)),
                _buildCheckbox("Floor Cleaning", floorCleaning,
                        (v) => setState(() => floorCleaning = v!)),
                _buildCheckbox("Deep Cleaning", deepCleaning,
                        (v) => setState(() => deepCleaning = v!)),
                _buildCheckbox("Moving Cleaning", movingCleaning,
                        (v) => setState(() => movingCleaning = v!)),
                _buildCheckbox("Bathroom Cleaning", bathroomCleaning,
                        (v) => setState(() => bathroomCleaning = v!)),
              ],
            ),

            const SizedBox(height: 20),

            // ---------------- COMMERCIAL CLEANING ----------------
            _buildCategoryCard(
              "Commercial Cleaning",
              [
                _buildCheckbox("Office Cleaning", officeCleaning,
                        (v) => setState(() => officeCleaning = v!)),
                _buildCheckbox("Sports Cleaning", sportsCleaning,
                        (v) => setState(() => sportsCleaning = v!)),
                _buildCheckbox("Window Cleaning", windowCleaning,
                        (v) => setState(() => windowCleaning = v!)),
                _buildCheckbox("Window Cleaning", windowCleaning2,
                        (v) => setState(() => windowCleaning2 = v!)),
                _buildCheckbox("Medical Cleaning", medicalCleaning,
                        (v) => setState(() => medicalCleaning = v!)),
              ],
            ),

            const SizedBox(height: 25),

            // ---------------- SUBMIT BUTTON ----------------
            GestureDetector(
              onTap: () {
                setState(() {
                  submitPressed = true;
                });
              },
              child: Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  color: submitPressed
                      ? Colors.blue.shade900   // dark blue
                      : Colors.lightBlueAccent.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ---------------- CATEGORY CARD ----------------
  Widget _buildCategoryCard(String title, List<Widget> items) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        color: const Color(0xFFF8F9FD),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const Divider(height: 25),
          ...items,
        ],
      ),
    );
  }

  // ---------------- CHECKBOX BUILDER ----------------
  Widget _buildCheckbox(
      String label, bool value, ValueChanged<bool?> onChanged) {
    return Row(
      children: [
        Checkbox(
          shape: const CircleBorder(),
          value: value,
          activeColor: Colors.lightBlueAccent,
          onChanged: onChanged,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: value ? Colors.black87 : Colors.grey,
          ),
        ),
      ],
    );
  }
}
