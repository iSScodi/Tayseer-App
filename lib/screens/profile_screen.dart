import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String name;
  const ProfileScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(radius: 50, backgroundImage: AssetImage('assets/images/houla.png')),
          const SizedBox(height: 16),
          Text(name, style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text("Active user", style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Profile settings coming soon!")),
              );
            },
            icon: const Icon(Icons.settings),
            label: const Text("Edit Profile"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown[700],
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}