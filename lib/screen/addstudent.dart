import 'dart:io';
import 'package:app/controller/addStudentController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
                                                              

class AddStudent extends StatelessWidget {
  const AddStudent({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<AddStudentController>(context,listen:false).clearForm();
    return Consumer<AddStudentController>(
      builder:(context,studentController,child)
      => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 117, 238, 177),
          title: const Text('Add Student'),
          actions: [
            TextButton.icon(
              label: const Text('Save'),
              onPressed: () {
                studentController.addStudentClicked(context,studentController);
                Get.back();
              },
              icon: const Icon(Icons.save_rounded),
            )
          ],
          centerTitle: true,
        ),
        backgroundColor: Colors.cyan.shade100,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: studentController.formKey, // The form key
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                            backgroundImage: studentController.imagepath.isNotEmpty
                                ? FileImage(File(studentController.imagepath))
                                : null 
                                    ,
                            radius: 100),
        
                      Positioned(
                        bottom: 20,
                        right: 5,
                        child: IconButton(
                          onPressed: () {
                            studentController.addphoto(context,studentController);
                          },
                          icon: const Icon(Icons.add_a_photo_outlined),
                          color: const Color.fromARGB(255, 255, 255, 255),
                          iconSize: 40,
                        ),
                      ),
                    ],
                  ),
      
                  const SizedBox(height: 50),
      
                  // Name input field with validation
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: studentController.nameController,
                    decoration: InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      suffixIcon: const Icon(Icons.abc_outlined),
                      suffixIconColor: Colors.purple,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
      
                  // Age input field with validation
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: studentController.ageController,
                    decoration: InputDecoration(
                      labelText: "Age",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      suffixIcon: const Icon(Icons.perm_contact_cal_sharp),
                      suffixIconColor: Colors.purple,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Age';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
      
                  // Guardian input field with validation
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: studentController.fatherController,
                    decoration: InputDecoration(
                      labelText: "Guardian",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      suffixIcon: const Icon(Icons.person),
                      suffixIconColor: Colors.purple,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a Guardian';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
      
                  // Mobile input field with validation
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: studentController.pnumberController,
                    decoration: InputDecoration(
                      labelText: "Mobile",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      suffixIcon: const Icon(Icons.phone_sharp),
                      suffixIconColor: Colors.purple,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a Mobile';
                      } else if (value.length != 10) {
                        return 'Mobile number should be 10 digits';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}