import 'package:flutter/material.dart';

class AppBarcustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarcustom(
    {
      super.key,
      required this.title,
    });

  final String title;


  @override
  Widget build(BuildContext context) {
    return AppBar(
    
        title: Text(title, style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        )),
        backgroundColor: Color.fromARGB(255, 118, 65, 192),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
        Navigator.of(context).pop();
        },
        ),
      );
      
      
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight ); 
  
  }