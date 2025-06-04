import 'package:flutter/material.dart';
import 'package:tayseer__app/screens/municipality_screen.dart';
import 'package:tayseer__app/widgets/background.dart';
import 'package:tayseer__app/widgets/textfieldCustom.dart';


class Registerscreen
 extends StatelessWidget {
   Registerscreen
  ({super.key});

  final TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context)
  { 

   return Background(title: 'Register',
   child:
   Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
           // Register form
              Column(
                  children: [

            //container for the form
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: 350,
                        width: 350,
                        decoration: BoxDecoration(
                        boxShadow: List.empty(growable: true)
                        ..add(BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: Offset(10, 25),
                          )),
                        color: const Color.fromARGB(255, 230, 197, 245),
                        borderRadius: BorderRadius.circular(10), ),
            //information form
                        child: Column( 
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: 
                        [
                          TextFieldCustom(nameController: nameController , hintText: 'Enter your Username',),
                          SizedBox(height: 30),
                          TextFieldCustom(hintText: "Enter your email",),
                          SizedBox(height: 30),
                          TextFieldCustom(hintText: "Enter your password",),
                          SizedBox(height: 20),
                          TextButton(onPressed: ()
                          {
             // Validate that user entered a name 
                            if (nameController.text.isEmpty) { 
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Name cannot be empty")),
                              );
                              return;
                            }
             // Navigate to MunicipalityScreen
                             Navigator.of(context).push(
                             MaterialPageRoute(builder: (context) => MunicipalityScreen(name: nameController.text)),
                           );
                          },
                           child: Text('Register'))
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
   );
  }
}


  