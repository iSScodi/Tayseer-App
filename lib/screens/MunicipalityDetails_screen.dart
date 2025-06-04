import 'package:flutter/material.dart';
import 'package:tayseer__app/data/municipalities.dart';
import 'package:tayseer__app/models/blog.dart';
import 'package:tayseer__app/screens/addPost_screen.dart';
import 'package:tayseer__app/widgets/filterPosts.dart';



class MunicipalityDetailsScreen extends StatefulWidget {
  const MunicipalityDetailsScreen({super.key, required this.id});

  final int id;

  @override
  State<MunicipalityDetailsScreen> createState() => _MunicipalityDetailsScreenState();
}

class _MunicipalityDetailsScreenState extends State<MunicipalityDetailsScreen> {

   final List<Blogs> blogs=[];
   String municipalityName = "municipality";



  @override
  void initState() {
    super.initState();
    municipalityName = municipalitiesData[widget.id] ?? "municipality";

  }
  @override
  Widget build(BuildContext context) 
  {

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            municipalityName,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 118, 65, 192),
          centerTitle: true,
          leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
           Navigator.of(context).pop();
          },
        ),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'Donations'),
              Tab(text: 'Services'),
              Tab(text: 'Volunteers'),
              Tab(text: 'Tenders'),
            ],
          ),
      ),
      body: TabBarView(
        children: 
        [
          FilterPosts(category: "Donation", blogs: blogs), 
          FilterPosts(category: "Service", blogs: blogs), 
          FilterPosts(category: "Volunteer", blogs: blogs), 
          FilterPosts(category: "Tender", blogs: blogs), 
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async
          {
           final newPost = await  
           Navigator.push(
           context,
           MaterialPageRoute(builder: (context) => AddpostScreen(MunId: widget.id)));

           if (newPost != null) {
             setState(() {
               blogs.add(newPost);
             });
           }
         },//onPressed
         backgroundColor: const Color.fromARGB(255, 118, 65, 192),
         child: const Icon(Icons.add, color: Colors.white,),
       ),
      )
    );
  }
}
      