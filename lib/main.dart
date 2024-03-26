import 'package:app/controller/addStudentController.dart';
import 'package:app/controller/bottom_controller.dart';
import 'package:app/controller/editStudentController.dart';
import 'package:app/controller/student_controller.dart';
import 'package:app/database/db_functions.dart';
import 'package:app/screen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  await initializeDatabase();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AddStudentController()),
        ChangeNotifierProvider(create: (context) => EditStudentController()),
        ChangeNotifierProvider(create: (context) => StudentController()),
        ChangeNotifierProvider(create: (context) => BottomController()),
      ], 
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const HomeScreeen(),
    );
  }
}
