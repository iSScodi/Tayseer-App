import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Addmunicipality extends StatefulWidget {
  const Addmunicipality({super.key, required this.name});

  final String name;

  @override
  State<Addmunicipality> createState() => _AddFromUserState();
}

class _AddFromUserState extends State<Addmunicipality> {
  final nameController = TextEditingController();
  final pictureLinkController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isSubmitting = false;

  @override
  void dispose() {
    nameController.dispose();
    pictureLinkController.dispose();
    super.dispose();
  }

  Future<void> postMunicipality(String name, String imagePath) async {
    final url = Uri.parse('http://127.0.0.1:8000/municipalities/');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'imagePath': imagePath,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to submit: ${response.body}');
    }
  }

  void handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final name = nameController.text.trim();
    final picture = pictureLinkController.text.trim();

    setState(() => isSubmitting = true);

    try {
      await postMunicipality(name, picture);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Municipality added successfully!')),
      );
      nameController.clear();
      pictureLinkController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 217, 199),
      body: SafeArea( // Keeps content clear of notches/status bar
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text("Add Municipality", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 114, 82, 56),),),
                const SizedBox(height: 16),


                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter a name' : null,
                ),
                const SizedBox(height: 16),


                TextFormField(
                  controller: pictureLinkController,
                  decoration: const InputDecoration(
                    labelText: 'Picture Link',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.url,
                ),
                const SizedBox(height: 24),


                ElevatedButton(
                  onPressed: isSubmitting ? null : handleSubmit,
                  child: isSubmitting
                      ? const CircularProgressIndicator()
                      : const Text('Submit'),
                ),
                const SizedBox(height: 16),               
              ],
            ),
          ),
        ),
      ),
    );
  }
}