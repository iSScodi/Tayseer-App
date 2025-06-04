import 'package:flutter/material.dart';
import 'package:tayseer__app/data/municipalities.dart';
import 'package:tayseer__app/screens/MunicipalityDetails_screen.dart';



class MunicipalityScreen extends StatelessWidget {
  const MunicipalityScreen({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) { 
    return  Scaffold(
      appBar: AppBar(
        title: const Text( 
          "Municipality",
          style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,),),
          backgroundColor: const Color.fromARGB(255, 118, 65, 192),
          centerTitle: true,
          automaticallyImplyLeading: false,
      ),

     
      //background color managing 
      body: Container(
          decoration: const BoxDecoration(
          gradient: LinearGradient(
          colors:[
              Color.fromARGB(255, 118, 65, 192),
              Color.fromARGB(255, 118, 65, 192),
                 ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            children:
             [


           //child one
              const SizedBox(height: 30),
              Text(
                "Hello $name😊 , Join your municipality Connect to people",
                style: const TextStyle(
                color: Color.fromARGB(255, 228, 171, 255),
                fontSize: 20,),
                textAlign: TextAlign.center,
              ),
         
             const SizedBox(height: 20),

           //child two
              Expanded(
                child: ListView.builder(
                  itemCount: municipalitiesData.keys.length,
                  itemBuilder: (context, index) {
                    final municipalityName = municipalitiesData.values.elementAt(index);
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        title: Text(municipalityName.toString()),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          int municipalityId = municipalitiesData.keys.elementAt(index);  
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MunicipalityDetailsScreen(id: municipalityId)
                            ),
                          );
                        },
                        
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}