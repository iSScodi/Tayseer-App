import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        )),
        backgroundColor: const Color.fromARGB(255, 114, 82, 56),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
         
         image: DecorationImage(image: AssetImage("assets/images/background.jpg"),
         fit: BoxFit.cover,
         
         
         )
        ),
        child: Center(child: child),
      ),
    );
  }
}