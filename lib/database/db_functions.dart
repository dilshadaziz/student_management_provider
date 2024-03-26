// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:app/controller/student_controller.dart';
import 'package:app/database/db_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

late Database _db;
Future<void> initializeDatabase() async {
  _db = await openDatabase(
    'student_db.db',
    version: 1,
    onCreate: (Database db, version) async {
      await db.execute(
          'CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT, age TEXT, father TEXT, pnumber TEXT, imagex TEXT)');
    },
    
  );
  print("Database created successfully.");
}
  
Future<List<StudentModel>> getstudentdata() async {
  final result = await _db.rawQuery("SELECT * FROM student");
  debugPrint('All Students data : $result');
  List<StudentModel> list = [];
  for (var map in result) {
    final student = StudentModel.fromMap(map);
    list.add(student);
  }
  return list;
}

Future<void> addstudent(StudentModel students,context) async {
  try {
    await _db.rawInsert(
      'INSERT INTO student(name,age,father,pnumber,imagex) VALUES(?,?,?,?,?)',
      [students.name, students.age, students.father, students.pnumber, students.imagex],
    );
    getstudentdata();
    await Provider.of<StudentController>(context).initialize();
  } catch (e) {
    debugPrint('Error inserting data: $e');
  }
}

Future<void> deleteStudent(id,context) async {
  await _db.delete('student', where: 'id=?', whereArgs: [id]);
  getstudentdata();
  await Provider.of<StudentController>(context).initialize();
}

Future<void> editStudent(id, name, age, father, pnumber, imagex,context) async {
  final dataflow = {
    'name': name,
    'age': age,
    'father': father,
    'pnumber': pnumber,
    'imagex': imagex,
  };
  await _db.update('student', dataflow, where: 'id=?', whereArgs: [id]);
  getstudentdata();
  await Provider.of<StudentController>(context).initialize();
}