import 'package:flutter/material.dart';
class BottomController extends ChangeNotifier{
  int selectedIndex = 0;
  int viewMode = 0;


  changeScreen(int value){
    selectedIndex = value;
    viewMode = value;
    notifyListeners();
  }
}