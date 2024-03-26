import 'dart:io';
import 'package:app/controller/student_controller.dart';
import 'package:app/screen/studentdetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentListGridView extends StatelessWidget {
  const StudentListGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<StudentController>(context).initialize();
    return Consumer<StudentController>(
      builder:(context,studentController,child
      )=> GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Set the number of columns here
        ),
        itemCount: studentController.studentLists.length,
        itemBuilder: (context, index) {
          final student = studentController.studentLists[index];
      
          return Card(
            margin: const EdgeInsets.all(10),
            elevation: 1,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctr) => StudentDetails(stdetails: student),
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: FileImage(
                      File(student.imagex),
                    ),
                    radius: 30,
                  ),
                  const SizedBox(height: 12),
                  Text(student.name),
                  Text(
                    "Age: ${student.age}, \nMobile: +91 - ${student.pnumber}",
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
