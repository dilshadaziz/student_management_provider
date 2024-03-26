import 'package:app/controller/bottom_controller.dart';
import 'package:app/screen/addstudent.dart';
import 'package:app/screen/gridscreen.dart';
import 'package:app/screen/listscreen.dart';
import 'package:app/screen/searchscreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomeScreeen extends StatelessWidget {
   const HomeScreeen({super.key});

 // 0 for Grid, 1 for List
  @override
  Widget build(BuildContext context) {
    return Consumer<BottomController>(
      builder:(context,bottomController,child)=>
      Scaffold(
        backgroundColor: Colors.indigoAccent.shade100,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 117, 238, 177),
          title: const Text('Students Record'),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => SearchScreen());
                },
                icon: const Icon(Icons.search_rounded))
          ],
        ),
        body: Column(
            children: [
              Expanded(
                  child:bottomController.viewMode == 0
                      ? const StudentListGridView()
                      : const StudentList()), 
                    
                  
            ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: Visibility(
          visible: true, // Show the add button
          child: FloatingActionButton(
            backgroundColor: Colors.deepPurple.shade100,
            shape: const CircleBorder(),
            elevation: 2, // shadow
            onPressed: () {
              addstudent(context);
            },
            child: const Icon(Icons.add),
          ),
        ),
        bottomNavigationBar: Consumer(
      builder: (context,value,child)=>
          CurvedNavigationBar(items: const [
             Icon(Icons.grid_view_outlined,),
             Icon(Icons.list),
          ],
          color: Colors.teal.shade200,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.indigoAccent.shade100,
          
          animationDuration: const Duration(milliseconds: 300),
          
          index: bottomController.selectedIndex,
            onTap: (int index) {
              bottomController.changeScreen(index);
            },
          
          ),
        ),
      
      ),
    );
  }

  void addstudent(gtx) {
    Get.to(()=>const AddStudent());
  }
}