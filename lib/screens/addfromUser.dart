// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:tayseer__app/screens/munListScreen.dart';

// class AddFromUser extends StatefulWidget {
//   const AddFromUser({super.key});

//   @override
//   State<AddFromUser> createState() => _AddFromUserState();
// }

// class _AddFromUserState extends State<AddFromUser> {
//   final idController = TextEditingController();
//   final nameController = TextEditingController();
//   final pictureLinkController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool isSubmitting = false;

//   @override
//   void dispose() {
//     idController.dispose();
//     nameController.dispose();
//     pictureLinkController.dispose();
//     super.dispose();
//   }

//   Future<void> postMunicipality(int id, String name, String imagePath) async {
//     final url = Uri.parse('http://127.0.0.1:8000/municipalities/');

//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'id': id,
//         'name': name,
//         'imagePath': imagePath,
//       }),
//     );

//     if (response.statusCode != 200 && response.statusCode != 201) {
//       throw Exception('Failed to submit: ${response.body}');
//     }
//   }

//   void handleSubmit() async {
//     if (!_formKey.currentState!.validate()) return;

//     final id = int.tryParse(idController.text);
//     final name = nameController.text.trim();
//     final picture = pictureLinkController.text.trim();

//     if (id == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter a valid numeric ID')),
//       );
//       return;
//     }

//     setState(() => isSubmitting = true);

//     try {
//       await postMunicipality(id, name, picture);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Municipality added successfully!')),
//       );
//       idController.clear();
//       nameController.clear();
//       pictureLinkController.clear();
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     } finally {
//       setState(() => isSubmitting = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Municipality'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextFormField(
//                 controller: idController,
//                 decoration: const InputDecoration(
//                   labelText: 'ID',
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.number,
//                 validator: (value) =>
//                     value == null || value.isEmpty ? 'Enter an ID' : null,
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: nameController,
//                 decoration: const InputDecoration(
//                   labelText: 'Name',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) =>
//                     value == null || value.isEmpty ? 'Enter a name' : null,
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: pictureLinkController,
//                 decoration: const InputDecoration(
//                   labelText: 'Picture Link',
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.url,
//               ),
//               const SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: isSubmitting ? null : handleSubmit,
//                 child: isSubmitting
//                     ? const CircularProgressIndicator()
//                     : const Text('Submit'),
//               ),

//               SizedBox(height: 16),

//               ElevatedButton(onPressed: (){

//                 Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => Munlistscreen()));

                
//               }, child:  Text("view the list of municipalites ") ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }