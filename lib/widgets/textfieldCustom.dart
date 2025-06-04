import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom({super.key, this.nameController, required this.hintText}); 

  final TextEditingController? nameController; 
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextField(
        controller: nameController, 
        decoration: InputDecoration(
          labelText: hintText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}