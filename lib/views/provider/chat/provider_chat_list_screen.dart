import 'package:flutter/material.dart';
import 'provider_chat_detail_screen.dart';

class ProviderChatListScreen extends StatelessWidget {
  const ProviderChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text(
          "Chat",
          style: TextStyle(
            color: Color(0xFF2A2D52),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.notifications_none, color: Colors.blue),
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          _chatItem(
            context: context,
            imagePath: "assets/images/bathroom_cleaner.png",
            name: "Tylor Smith",
            message: "Great! Thank You so much …",
            badge: "7+",
          ),
          _chatItem(
            context: context,
            imagePath: "assets/images/user_avatar.jpg",
            name: "Tylor Smith",
            message: "Great! Thank You so much …",
            badge: "3+",
          ),
          _chatItem(
            context: context,
            imagePath: "assets/images/chimny_cleaner.png",
            name: "Tylor Smith",
            message: "Great! Thank You so much …",
            badge: "5+",
          ),
          _chatItem(
            context: context,
            imagePath: "assets/images/user_avatar.jpg",
            name: "Tylor Smith",
            message: "Great! Thank You so much …",
            badge: "1",
          ),
        ],
      ),
    );
  }

  // ---------------- CHAT ITEM WIDGET ----------------
  Widget _chatItem({
    required BuildContext context,
    required String imagePath,
    required String name,
    required String message,
    required String badge,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ProviderChatDetailScreen(),
          ),
        );
      },

      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 5,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage(imagePath),
            ),

            const SizedBox(width: 12),

            // Name + Message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            // Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                badge,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
