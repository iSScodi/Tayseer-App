import 'package:flutter/material.dart';
import 'package:tayseer__app/models/blog.dart';






class FilterPosts extends StatelessWidget {
  const FilterPosts({super.key, required this.category, required this.blogs});

  final String category;
  final List<Blogs> blogs;


  @override
  Widget build(BuildContext context) {
    List<Blogs> filteredBlogs = blogs.where((post) => post.category == category).toList();
    return filteredBlogs.isEmpty
        ? Center(child: Text("No posts available for $category"))
        : ListView.builder(
            itemCount: filteredBlogs.length,
            itemBuilder: (context, index) {
              final post = filteredBlogs[index];
               return Card(
                color: const Color.fromARGB(255, 212, 184, 228),
                
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
 
                      if (category == "Donation") Icon(Icons.money),
                      if (category == "Service") Icon(Icons.event),
                      if (category == "Tender") Icon(Icons.business),
                      if (category == "Volunteer") Icon(Icons.volunteer_activism),
                   
             
                      Text(post.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      SizedBox(height: 8),
                      Text(post.content),
                      SizedBox(height: 8),
                      if (post.moneyneeded != null) Text("Money Needed: \$${post.moneyneeded}"),
                      if (post.volunteersneeded != null) Text("Volunteers Needed: ${post.volunteersneeded}"),
                      if (post.date != null && category != "Tender") Text("Date: ${post.date}"),
                      if (post.date != null) Text("Deadline for submission: ${post.date}"),
                      if (post.time != null && (category != "Tender" || category != "Donation" )) Text("Time: ${post.time}"),
                      if (post.location != null && (category == "Service" || category == "Volunteer")) Text("Location: ${post.location}"),
                      SizedBox(height: 8),
                      
                    ],
                  ),
                ),
              );
            },
          );
  }
}

