// register_screen.dart
import 'package:flutter/material.dart';
import 'package:tayseer__app/screens/login_screen.dart';
import 'package:tayseer__app/screens/municipality_screen.dart';
import 'package:tayseer__app/widgets/background.dart';
import 'package:tayseer__app/widgets/textfieldCustom.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> registerUser() async {
    final email = emailController.text.trim();
    final username = nameController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    if (!EmailValidator.validate(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Enter a valid email")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse("http://127.0.0.1:8000/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "username": username,
          "password": password,
          "profile_picture": null,
        }),
      );

      setState(() => isLoading = false);

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration successful")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => MunicipalityScreen(name: username),
          ),
        );
      } else {
        final error = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error["detail"] ?? "Registration failed")),
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      title: "Register",
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.all(20),
            width: 350,
            decoration: BoxDecoration(
              color: Color.fromARGB(106, 94, 65, 27),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                TextFieldCustom(
                  nameController: nameController,
                  hintText: "Enter your Username",
                ),
                SizedBox(height: 20),
                TextFieldCustom(
                  nameController: emailController,
                  hintText: "Email",
                ),
                SizedBox(height: 20),
                TextFieldCustom(
                  nameController: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),
                SizedBox(height: 30),
                isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: registerUser,
                        child: Text("Register",style: TextStyle(color: const Color.fromARGB(255, 160, 123, 74)),),
                      ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => LoginScreen()),
                    );
                  },
                  child: Text("Already have an account? Login", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
