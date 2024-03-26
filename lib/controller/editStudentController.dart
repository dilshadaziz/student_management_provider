import 'package:app/database/db_functions.dart';
import 'package:app/database/db_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


class EditStudentController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  String updatedImagePath = '';
  final editNameController = TextEditingController();
  final editAgeController = TextEditingController();
  final editFatherController = TextEditingController();
  final editPnumberController = TextEditingController();

  addImage(String image){
    updatedImagePath = image;
    notifyListeners();
  }

  void initialValue({
    required String imagePath,
    required String name,
    required String age,
    required String father,
    required String pnumber,
  }){
    updatedImagePath = imagePath;
    editNameController.text = name;
    editAgeController.text = age;
    editFatherController.text = father;
    editPnumberController.text = pnumber;

  }
  // Function to handle image selection
  Future<void> geterimage(ImageSource source,EditStudentController editStudentController) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    editStudentController.addImage(image.path);
  }

  // Function to handle edit student button click
  Future<void> editStudentClicked(BuildContext context,StudentModel student,EditStudentController editStudentController) async {
    if (formKey.currentState!.validate()) {
      final name = editNameController.text.toUpperCase();
      final age = editAgeController.text.trim();
      final father = editFatherController.text;
      final phonenumber = editPnumberController.text.trim();

      final updatedStudent = StudentModel(
        id: student.id,
        name: name,
        age: age,
        father: father,
        pnumber: phonenumber,
        imagex: editStudentController.updatedImagePath,
      );

      Get.back();
      await editStudent(
        updatedStudent.id!,
        updatedStudent.name,
        updatedStudent.age,
        updatedStudent.father,
        updatedStudent.pnumber,
        updatedStudent.imagex,
        context,
      );

      // getstudentdata();
    }
  }

  // Function to show photo selection dialog
  void editPhoto(ctx,EditStudentController editStudentController) {
    Get.dialog(
      AlertDialog(
        title: const Text('Update Photo'),
        actions: [
          Column(
            children: [
              Row(
                children: [
                  const Text('Choose from camera'),
                  IconButton(
                    onPressed: () {
                      geterimage(ImageSource.camera,editStudentController);
                      Get.back();
                    } ,
                    icon: const Icon(Icons.camera_alt_rounded),
                  
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('Choose from gallery'),
                  IconButton(
                    onPressed: () {
                      geterimage(ImageSource.gallery,editStudentController);
                      Get.back();
                    },
                    icon: const Icon(Icons.image),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}