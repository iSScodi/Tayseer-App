import 'package:flutter/material.dart';

class TextFieldCustom extends StatefulWidget {
  const TextFieldCustom({
    super.key,
    this.nameController,
    required this.hintText,
    this.obscureText = false,
    this.inputType = TextInputType.text,
    this.validator,
  });

  final TextEditingController? nameController;
  final String hintText;
  final bool obscureText;
  final TextInputType inputType;
  final String? Function(String?)? validator;

  @override
  State<TextFieldCustom> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  late bool isObscured;

  @override
  void initState() {
    super.initState();
    isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextFormField(
        controller: widget.nameController,
        obscureText: isObscured,
        keyboardType: widget.inputType,
        validator: widget.validator,
        decoration: InputDecoration(
          hintText: widget.hintText, // 👈 hint, not label
          hintStyle: const TextStyle(
            color: Color.fromARGB(255, 116, 90, 20),
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: const Color.fromARGB(172, 255, 237, 190),
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    isObscured ? Icons.visibility_off : Icons.visibility,
                    color: Color.fromARGB(255, 82, 49, 0),
                  ),
                  onPressed: () {
                    setState(() {
                      isObscured = !isObscured;
                    });
                  },
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 82, 49, 0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 176, 139, 39),
              width: 2.0,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}