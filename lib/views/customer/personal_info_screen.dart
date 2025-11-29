import 'package:flutter/material.dart';
import 'package:service_booking_app/views/common/provider_list_screen.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  PersonalInfoScreenState createState() => PersonalInfoScreenState();
}

class PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _jobTypeController = TextEditingController();
  final TextEditingController _projectLengthController = TextEditingController();

  // -------------------------------------------------------------------
  // ⭐ TEXTFIELD CARD FUNCTION (Label + Blue Border + Grey Input Text)
  // -------------------------------------------------------------------
  Widget buildTextFieldCard(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Label
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black, // Label black
          ),
        ),
        const SizedBox(height: 6),

        // Blue Border TextField Box
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 1.3),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: TextField(
            controller: controller,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black, // Inside text grey
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "",
            ),
          ),
        ),

        const SizedBox(height: 18),
      ],
    );
  }

  // -------------------------------------------------------------------
  // ⭐ ALERT DIALOG
  // -------------------------------------------------------------------
  void showAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 18),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "OK",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // -------------------------------------------------------------------
  // ⭐ SUBMIT
  // -------------------------------------------------------------------
  void _onSubmit() {
    if (_userNameController.text.isEmpty ||
        _contactController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _jobTypeController.text.isEmpty ||
        _projectLengthController.text.isEmpty) {
      showAlert("Missing Information",
          "Please fill out all fields before continuing.");
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProviderListScreen(
          userName: _userNameController.text,
          contact: _contactController.text,
          location: _locationController.text,
          jobType: _jobTypeController.text,
          projectLength: _projectLengthController.text,
        ),
      ),
    );
  }

  // -------------------------------------------------------------------
  // ⭐ UI STARTS
  // -------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white ,

      appBar: AppBar(
        title: const Text("Personal Information"),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,

        elevation: 1,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTextFieldCard("Name", _userNameController),
            buildTextFieldCard("Mobile Number", _contactController),
            buildTextFieldCard("Location", _locationController),
            buildTextFieldCard("Job Type", _jobTypeController),
            buildTextFieldCard("Project Length", _projectLengthController),

            const SizedBox(height: 10),

            // Submit Button
            GestureDetector(
              onTap: _onSubmit,
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.blue,
                ),
                child: const Center(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
