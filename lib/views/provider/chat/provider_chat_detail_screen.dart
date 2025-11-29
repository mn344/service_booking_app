import 'package:flutter/material.dart';

class ProviderChatDetailScreen extends StatelessWidget {
  const ProviderChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,

      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            const CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage("assets/images/user_avatar.jpg"),
            ),
            const SizedBox(width: 10),
            const Text(
              "Tylor Smith",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              children: [
                const SizedBox(height: 10),

                Center(
                  child: Text(
                    "Today at 8 : 49",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 12,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ---------------- LEFT MESSAGE ----------------
                _leftMessage(
                  img: "assets/images/user_avatar.jpg",
                  msg: "Hi! How’s your day?",
                  time: "8:49",
                ),

                const SizedBox(height: 18),

                // ---------------- RIGHT MESSAGE ----------------
                _rightMessage(
                  msg: "Good! Yours?",
                  time: "8:50",
                ),

                const SizedBox(height: 18),

                _leftMessage(
                  img: "assets/images/user_avatar.jpg",
                  msg: "Not bad. Any fun plans?",
                  time: "9:12",
                ),

                const SizedBox(height: 18),

                _rightMessage(
                  msg: "Movie night. You?",
                  time: "9:13",
                ),

                const SizedBox(height: 18),

                _leftMessage(
                  img: "assets/images/user_avatar.jpg",
                  msg: "Nice! Dinner with friends.",
                  time: "9:18",
                ),

                const SizedBox(height: 18),

                _rightMessage(
                  msg: "Enjoy! 😊",
                  time: "9:19",
                ),

                const SizedBox(height: 25),
              ],
            ),
          ),

          // ---------------- BOTTOM TYPING BAR ----------------
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 6,
                  color: Colors.black.withOpacity(0.05),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F5F9),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: "Type a message",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // Purple Send Button
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Color(0xFF4C1DE5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- LEFT MESSAGE BUBBLE ----------------
  Widget _leftMessage({required String img, required String msg, required String time}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CircleAvatar(
          radius: 22,
          backgroundImage: AssetImage(img),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F7),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  msg,
                  style: const TextStyle(fontSize: 15, color: Colors.black87),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                time,
                style: TextStyle(fontSize: 11, color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------- RIGHT MESSAGE BUBBLE ----------------
  Widget _rightMessage({required String msg, required String time}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFECEAFE),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  msg,
                  style: const TextStyle(fontSize: 15, color: Colors.black87),
                ),
              ),
              const SizedBox(height: 4),

              // time + double tick
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    time,
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.done_all, color: Colors.blue, size: 16),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
