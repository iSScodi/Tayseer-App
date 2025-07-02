import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String? profileImagePath;

  const AppDrawer({
    super.key,
    required this.userName,
    required this.userEmail,
    this.profileImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 255, 248, 220),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 114, 82, 56),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: profileImagePath != null
                  ? AssetImage(profileImagePath!)
                  : AssetImage('assets/images/default_profile.png'),
            ),
            accountName: Text(userName),
            accountEmail: Text(userEmail),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {
              // Handle logout
            },
          ),
        ],
      ),
    );
  }
}