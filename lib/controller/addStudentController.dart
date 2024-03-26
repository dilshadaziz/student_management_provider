import 'package:app/database/db_functions.dart';
import 'package:app/database/db_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddStudentController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  String imagepath = '';

  addImage(String image){
    imagepath = image;
    notifyListeners();
  }


  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final fatherController = TextEditingController();
  final pnumberController = TextEditingController();

  clearForm(){
    imagepath = "";
    nameController.clear();
    ageController.clear();
    fatherController.clear();
    pnumberController.clear();
  }

  Future<void>  addStudentClicked(context,AddStudentController addStudentController)async{
    if(formKey.currentState!.validate() && addStudentController.imagepath.isNotEmpty){
      final name = addStudentController.nameController.text.toUpperCase();
      final age = addStudentController.ageController.text.toUpperCase();
      final father = addStudentController.fatherController.text.toUpperCase();
      final pnumber = addStudentController.pnumberController.text.trim();


      final stdData = StudentModel(name: name, age: age, father: father, pnumber: pnumber, imagex: addStudentController.imagepath);
      await addstudent(stdData,context);
      
    Get.back();
    Get.snackbar('Successfully Added', 'Stuent Added Successfully',snackStyle: SnackStyle.FLOATING,margin: const EdgeInsets.all(10),
    backgroundColor: Colors.white,duration: const Duration(seconds: 2),snackPosition: SnackPosition.BOTTOM,);
    }
  else{
    Get.snackbar('Warning', 'Please check that whether everything is added or not...',snackStyle: SnackStyle.FLOATING,backgroundColor: Colors.redAccent,margin: const EdgeInsets.all(10),duration: const Duration(seconds: 2));
  }
  }

   Future<void> getimage(ImageSource source,AddStudentController addStudentController) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) {
      return;
    }
    addStudentController.addImage(image.path);
  }

    void addphoto(ctxr,AddStudentController provider) {
    showDialog(
      context: ctxr,
      builder: (ctxr) {
        return AlertDialog(
          content: const Text('Choose Image From.......'),
          actions: [
            IconButton(
              onPressed: () {
                getimage(ImageSource.camera,provider);
                Get.back();
              },
              icon: const Icon(
                Icons.camera_alt_rounded,
                color: Colors.red,
              ),
            ),
            IconButton(
              onPressed: () {
                getimage(ImageSource.gallery,provider);
                Get.back();
              },
              icon: const Icon(
                Icons.image,
                color: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }
  }