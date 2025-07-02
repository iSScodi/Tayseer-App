import 'package:flutter/material.dart';
import 'package:tayseer__app/models/blog.dart';
// import 'package:file_picker/file_picker.dart';






class AddpostScreen extends StatefulWidget 
{
  const AddpostScreen({super.key, required this.MunId});

  final int MunId;

  @override
  State<AddpostScreen> createState() => _AddpostScreenState();
}





class _AddpostScreenState extends State<AddpostScreen> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController(); 
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _volunteersRequiredController = TextEditingController();
  final TextEditingController _donationAmountController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  
  final List<String> Category = [
    'Donation',
    'Service',
    'Volunteer',
    'Tender',
  ];
  String? selectedCategory = 'Donation'; 
  String? selectedTime;
  String? selectedDate;

  // Handler for picking a file (for Tender category)
  // Future<void> _handlePickFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();
  //   if (result != null) {
  //        ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('File selected: ${result.files.single.name}')),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('No file selected')),
  //     );
  //   }
  // }

//passing the newpost to previous screen 
void _submitPost() async {
  if (_formKey.currentState!.validate()) {
    final newPost = Blogs(
      municipalityId: widget.MunId,
      category: selectedCategory!,
      title: _titleController.text,
      content: _descriptionController.text,
      moneyneeded: selectedCategory == "Donation" ? int.tryParse(_donationAmountController.text) : null,
      volunteersneeded: selectedCategory == "Volunteer" ? int.tryParse(_volunteersRequiredController.text) : null,
      date: selectedDate,
      time: selectedTime,
      location: _locationController.text,
    );

    Navigator.pop(context, newPost); // Returns post to previous screen
  }
}
  

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: const Color.fromARGB(255, 199, 170, 108),
      appBar: AppBar(
        title: const Text('Add Post',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: const Color.fromARGB(255, 114, 82, 56),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        
//container for the form
        child: SingleChildScrollView(
          child: Container(
            
            
           margin: EdgeInsets.symmetric(horizontal: 20),
            width: 400,
            
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage("assets/images/background.jpg"),
                              fit: BoxFit.cover,
                            ),
                          boxShadow: List.empty(growable: true)
                          ..add(BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: Offset(10, 25),
                            )),
                          color: const Color.fromARGB(207, 122, 88, 60),
                          borderRadius: BorderRadius.circular(10), ),
          //information form
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
          
          //dropdown for category selection
                  SizedBox(
                      width: 300,
                      child: DropdownButton(
                        value: selectedCategory,
                        hint: Text('Select Category'),
                        items: Category.map((category) {
                        return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                          );
                        }).toList(),
                        onChanged: (value) {
                        setState(() {
                            selectedCategory = value;
                          });
                        },
                      ),
                    ),
          
                    SizedBox(height: 20),
          // TextField for title        
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                      controller: _titleController,
                      validator: (value) {
                        //validation 
                        if (value == null || value.isEmpty) return "Title is required";
                        return null;
                      },  
                      decoration: InputDecoration(
                      hintText: 'title ',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), ),),),
                
                    SizedBox(height: 20),
          // TextField for description
                    SizedBox(
                     width: 300,
                     child: TextFormField(
                     maxLines: 3,
                     controller: _descriptionController,
                     validator: (value) {
                      //validation 
                        if (value == null || value.isEmpty) return "Description is required";
                        return null;
                     },
                     decoration: InputDecoration(
                     hintText: 'Description',
                     border: OutlineInputBorder(),
                     contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),),)
                     ,),
          
                  


          
            //for file picking for tender                
                  //  SizedBox(height: 20),
                   
                  //  if(selectedCategory == "Tender")
                  //  ElevatedButton(
                  //  onPressed: _handlePickFile,
                  //  child: const Text("Upload Attachment"),
                  //  ),
          
                  SizedBox(height: 20),

                   // Conditional TextField for donation amount 
                     if (selectedCategory == "Donation")
                     SizedBox(
                      width: 300,
                      child: TextFormField(
                      controller: _donationAmountController,
                      validator: (value) {
                        if (value == null || value.isEmpty) return "Donation Amount is required";
                        if(int.tryParse(value) == null || int.parse(value) <= 0) return "Donation Amount must be greater than 0";
                        return null;
                      },
                      decoration: InputDecoration(
                      hintText: 'Donation Amount',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        ),
                        ),
                        ),
          
                    SizedBox(height: 20),
          
          //tender submission deadline
                     if (selectedCategory == "Tender")
                     SizedBox(
                     width: 300,
                     child: ElevatedButton(
                     onPressed: () async {
                     TimeOfDay? picked = await showTimePicker(
                     context: context,
                     initialTime: TimeOfDay.now(),
                       );
                     if (picked != null) {
                     setState(() {
                     selectedTime = picked.format(context);
                     });
                     }
                     },
                     child: Text(selectedTime ?? "Select deadline"),
                     ),
                   ),
          
                    SizedBox(height: 20),
          
          // SizedBox for date selection
                    if (selectedCategory == "Service" || selectedCategory == "Volunteer")
                    SizedBox(
                    width: 300,
                    child: ElevatedButton(
                    onPressed: () async {
                    DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(), 
                    firstDate: DateTime(2000),   
                    lastDate: DateTime(2100),  );
                  setState(() {
                    if (picked != null) {
                      selectedDate = "${picked.day}/${picked.month}/${picked.year}"; // Format date
                    }
                  }); }, child: Text(selectedDate ?? "Select Date"), ),),
          
                  const SizedBox(height: 20),
          // SizedBox for time selection
                     if (selectedCategory == "Service" || selectedCategory == "Volunteer" )
                     SizedBox(
                     width: 300,
                     child: ElevatedButton(
                     onPressed: () async {
                     TimeOfDay? picked = await showTimePicker(
                     context: context,
                     initialTime: TimeOfDay.now(),
                       );
                     if (picked != null) {
                     setState(() {
                     selectedTime = picked.format(context);
                     });
                     }
                     },
                     child: Text(selectedTime ?? "Select Time"),
                     ),
                   ),
          
                    const SizedBox(height: 20),
          
          // TextField for location
                     if (selectedCategory == "Service" || selectedCategory == "Volunteer" )
                     SizedBox(
                     width: 300,
                     child: TextFormField(
                     controller: _locationController,
                     decoration: const InputDecoration(
                     hintText: "Enter Location",
                     border: OutlineInputBorder(),  ),
                     validator: (value) {
                     if (value == null || value.isEmpty) return "Location is required";
                     return null;
                               },
                               ),
                               ),
          
                    SizedBox(height: 20),
          // Conditional TextField for volunteers             
                     if (selectedCategory == "Volunteer") 
                     SizedBox(
                      width: 300,
                      child: TextFormField(
                      controller: _volunteersRequiredController,
                       validator: (value) {
                        if (value == null || value.isEmpty) return "Number of Volunteers Required is required";
                        if(int.tryParse(value) == null || int.parse(value) <= 0) return "Number of Volunteers Required must be greater than 0";
                        return null;
                      },
                      decoration: InputDecoration(
                      hintText: 'Number of Volunteers Required',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        ),
                        ),
                        ),
          
                    SizedBox(height: 20),
         
          //submit
                    ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                      _submitPost();
                      }},
                      style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 102, 61, 33),
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Submit Post'),

                 
                  ),
                  
                  SizedBox(height: 60),
                ],
              )
            
            
            )
          ),
        ),
      ),
    );
  }
}