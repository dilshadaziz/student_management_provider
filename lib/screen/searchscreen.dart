import 'dart:io';
import 'package:app/controller/student_controller.dart';
import 'package:app/database/db_functions.dart';
import 'package:app/database/db_model.dart';
import 'package:app/screen/editstudent.dart';
import 'package:app/screen/studentdetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<StudentController>(context,listen:false).getSearchResults("");
    return Consumer<StudentController>(
      builder:(context,studentController,child)
      => Scaffold(
        backgroundColor: const Color.fromARGB(255, 186, 246, 240),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: TextField(
                    onChanged: (value) => context.read<StudentController>().getSearchResults(value),
                    decoration: const InputDecoration(
                      labelText: 'Search',
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Expanded(
                  child: Consumer<StudentController>(builder: (context,studentController,child)
                     => studentController.filteredStudentList.isEmpty? const Center(child:Text("No results found")) :  ListView.builder(
                      itemCount: studentController.filteredStudentList.length,
                      itemBuilder: (context, index) {
                        final finduserItem = studentController.filteredStudentList[index];
                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            
                            leading: CircleAvatar(
                              backgroundImage:
                                  FileImage(File(finduserItem.imagex)),
                            ),
                            title: Text(finduserItem.name),
                            subtitle: Text('CLASS : ${finduserItem.age}'),
                            trailing:Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Get.to(()=>EditStudent(student: finduserItem));
                        
                      },
                    ),
                    IconButton(
                      color: Colors.red,
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        deletestudent(context, finduserItem,);
                      },
                    ),
                                      ],
                                    ), 
                            onTap: () {
                              Get.off((ctr) =>
                                    StudentDetails(stdetails: finduserItem));
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    
  }

  void deletestudent(rtx, StudentModel student) {
    showDialog(
      context: rtx,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: const Text('Are you sure want to delete ?'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                delectYes(rtx, student);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void delectYes(ctx, StudentModel student) {
    deleteStudent(student.id!,ctx);

    Get.back();
    Get.snackbar('Deleted', 'Successfully Deleted',snackStyle: SnackStyle.FLOATING,margin: const EdgeInsets.all(10),backgroundColor: Colors.redAccent,duration: const Duration(seconds: 2));
  }
}