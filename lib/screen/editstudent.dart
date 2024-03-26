import 'dart:io';
import 'package:app/controller/editStudentController.dart';
import 'package:app/database/db_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


// ignore: must_be_immutable
class EditStudent extends StatelessWidget {
  StudentModel student;

  EditStudent({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    Provider.of<EditStudentController>(context,listen:false).initialValue(imagePath: student.imagex, name: student.name, age: student.age, father: student.father, pnumber: student.pnumber);
    return Consumer<EditStudentController>(
      builder:(context,studentEditController,child)=> Scaffold(
        backgroundColor: const Color.fromARGB(255, 186, 246, 240),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 197, 169, 248),
          title: const Text('Edit Student'),
          actions: [
            TextButton.icon(
              label: const Text('Update'),
              onPressed: ()async {
                try {
        debugPrint('Before calling editStudentClicked');
        studentEditController.editStudentClicked(
          context,
          student,
          studentEditController,
        );
        debugPrint('After calling editStudentClicked');
      } catch (e) {
        // Handle the error here or simply log it
        debugPrint('Error occurred: $e');
      
      }
              },
              icon: const Icon(Icons.cloud_upload),
            )
          ],
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: studentEditController.formKey, // Assign the form key
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        InkWell(
                          
                          onTap: () => studentEditController.editPhoto(context,studentEditController),
                          child: 
                            CircleAvatar(
                              backgroundImage: FileImage(File(studentEditController.updatedImagePath)),
                              radius: 80,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 50),
      
                    // Name input field with validation
                    Row(
                      children: [
                        const Icon(Icons.abc_outlined),
                        const SizedBox(
                            width: 10), // Add spacing between icon and text field
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            controller: studentEditController.editNameController,
                            decoration: InputDecoration(
                              labelText: "Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a Name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
      
                    // Age input field with validation
                    Row(
                      children: [
                        const Icon(Icons.perm_contact_cal),
                        const SizedBox(
                            width: 10), // Add spacing between icon and text field
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: studentEditController.editAgeController,
                            decoration: InputDecoration(
                              labelText: "Class",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your Age';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
      
                    // Guardian input field with validation
                    Row(
                      children: [
                        const Icon(Icons.person),
                        const SizedBox(
                            width: 10), // Add spacing between icon and text field
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            controller: studentEditController.editFatherController,
                            decoration: InputDecoration(
                              labelText: "Parent",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Parent Name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
      
                    // Mobile input field with validation
                    Row(
                      children: [
                        const Icon(Icons.phone_sharp),
                        const SizedBox(
                            width: 10), // Add spacing between icon and text field
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: studentEditController.editPnumberController,
                            decoration: InputDecoration(
                              labelText: "Mobile number",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a mobile number';
                              } else if (value.length != 10) {
                                return 'Mobile number should be 10 digits';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}