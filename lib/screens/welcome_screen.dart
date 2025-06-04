import 'package:flutter/material.dart';
import 'package:tayseer__app/screens/registerScreen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Stack(
          children:
           [
          
          //image background 
        Image.asset(
              'assets/images/welcome.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
           
       SizedBox(height: 400),

        //button get started
       Positioned(
               bottom: 100, 
               left: 130,
               right: 130,
               child: ElevatedButton(
               style: ElevatedButton.styleFrom(
               backgroundColor: const Color.fromARGB(166, 241, 228, 255),
               shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(30.0),
                  ),
                 
                ),
               onPressed: () {
                   Navigator.of(context).push(
                   MaterialPageRoute(builder: (context) => Registerscreen()),
                     );
               },
               child: Text("Get Started",),
              ), 
      ),  

          ],
        )
      );
    
  }
}