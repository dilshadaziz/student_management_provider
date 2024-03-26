import 'package:app/database/db_functions.dart';
import 'package:app/database/db_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentController extends ChangeNotifier{
  List<StudentModel> studentLists = <StudentModel>[];
  List<StudentModel> filteredStudentList = <StudentModel>[];
  initialize() async{
    var s1 = await getstudentdata();
    studentLists = s1;
    notifyListeners();
  }

  getSearchResults(String query) async{
    await initialize();
    if(query.isEmpty){
      filteredStudentList = studentLists;
    }
    else{
      List<StudentModel> s = studentLists.where((element) => element.name.toLowerCase().contains(query.toLowerCase())).toList();
      filteredStudentList = s;
    }
    notifyListeners();
  }
}