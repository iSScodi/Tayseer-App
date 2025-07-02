// login_screen.dart
import 'package:flutter/material.dart';
import 'package:tayseer__app/screens/registerScreen.dart';
import 'package:tayseer__app/screens/municipality_screen.dart';
import 'package:tayseer__app/widgets/background.dart';
import 'package:tayseer__app/widgets/textfieldCustom.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> loginUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter email and password")),
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
        Uri.parse("http://127.0.0.1:8000/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      setState(() => isLoading = false);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data["access_token"];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login successful")),
        );
       final username = data["username"] ?? "User"; 
        Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (_) => MunicipalityScreen(name: username)),
);

      } else {
        final error = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error["detail"] ?? "Login failed")),
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
      title: "Login",
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
                        onPressed: loginUser,
                        child: Text("Login",style: TextStyle(color: const Color.fromARGB(255, 160, 123, 74)),),
                      ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => Registerscreen()),
                    );
                  },
                  child: Text("New here? Create an account", style: TextStyle(color: const Color.fromARGB(235, 255, 255, 255))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
