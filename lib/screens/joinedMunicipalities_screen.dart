import 'package:flutter/material.dart';
import 'package:tayseer__app/data/municipalities.dart';
import 'package:tayseer__app/screens/MunicipalityDetails_screen.dart';

class JoinedMunicipalitiesScreen extends StatelessWidget {
  final String name;
  const JoinedMunicipalitiesScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    final matches = municipalitiesData.entries
        .where((entry) => entry.value.name.toLowerCase().contains(name.toLowerCase()))
        .toList();

    if (matches.isEmpty) {
      return const Center(
        child: Text("You're not joined with any municipality yet.", style: TextStyle(color: Colors.white)),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8),
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final entry = matches[index];
        final info = entry.value;
        return Card(
          color: const Color.fromARGB(255, 219, 216, 202),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(info.imagePath, width: 120, height: 120, fit: BoxFit.cover),
            ),
            title: Text(info.name,
                style: const TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 71, 54, 0))),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MunicipalityDetailsScreen(id: entry.key)),
              );
            },
          ),
        );
      },
    );
  }
}