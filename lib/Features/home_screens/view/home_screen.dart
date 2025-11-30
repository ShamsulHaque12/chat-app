
import 'package:chat_app/Features/home_screens/view/personal_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats",style: TextStyle(
          color: Colors.black,
          fontSize: 25.sp,
          fontWeight: FontWeight.bold,
        ),),
        actions: [

          GestureDetector(
            onTap: () {
              // Get.to(() => PersonalMessage());
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),

    );
  }
}
