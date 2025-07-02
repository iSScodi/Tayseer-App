import 'package:flutter/material.dart';
import 'package:tayseer__app/screens/AddMunicipality.dart';
import 'package:tayseer__app/screens/allMunicipalities_screen.dart';
import 'package:tayseer__app/screens/joinedMunicipalities_screen.dart';
import 'package:tayseer__app/screens/profile_screen.dart';

class MunicipalityScreen extends StatefulWidget {
  const MunicipalityScreen({super.key, required this.name});
  final String name;

  @override
  State<MunicipalityScreen> createState() => _MunicipalityScreenState();
}

class _MunicipalityScreenState extends State<MunicipalityScreen> {
  int selectedIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidgets = [
      AllMunicipalitiesScreen( userName: widget.name),
      JoinedMunicipalitiesScreen(name: widget.name),
      Addmunicipality(name: widget.name), 
      ProfileScreen(name: widget.name),
       // Uncomment if you have this screen
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tayseer",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 114, 82, 56),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 255, 248, 220),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 114, 82, 56),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/kawneen.png'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.name,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                 
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: () => Navigator.pop(context),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 114, 82, 56),
              Color.fromARGB(255, 192, 126, 65),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
           
           
            const SizedBox(height: 20),
            Expanded(child: screenWidgets[selectedIndex]),
          ],
        ),
      ),
        bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onTabTapped,
        selectedItemColor: const Color.fromARGB(255, 114, 82, 56),
        unselectedItemColor: Colors.grey[600],
        backgroundColor: const Color.fromARGB(255, 238, 217, 199),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.apartment),
            label: 'All',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.how_to_reg),
            label: 'Joined',

          ),
         
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}