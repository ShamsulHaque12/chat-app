import 'package:chat_app/Features/home_screens/view/personal_message.dart';
import 'package:chat_app/core/custom_widgets/custom_text_field.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          "Chats",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 25.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
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
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "All Story",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Obx(
                        () {
                      if (controller.isLoading.value) {
                        return Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        );
                      }
                      // Story list
                      return SizedBox(
                        height: 75.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.story.length + 1,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              // Add Icon
                              return GestureDetector(
                                onTap: () {
                                  // Add story logic
                                  print("Add story clicked");
                                },
                                child: Container(
                                  width: 60.w,
                                  margin: EdgeInsets.only(right: 10.w),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 30.r,
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.green,
                                          size: 30.sp,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        "Add",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                            // Story items
                            final story = controller.story[index - 1];
                            return Container(
                              width: 60.w,
                              margin: EdgeInsets.only(right: 10.w),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 30.r,
                                    backgroundImage: AssetImage(story.imagePath),
                                  ),
                                  SizedBox(height: 5.h),
                                  Text(
                                    story.name,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  // SizedBox(height: 8.h),
                  CustomTextField(
                    height: 30.h,
                    textEditingController: controller.searchController,
                    fillColor: Colors.white,
                    hintText: 'Search',
                    hintTextColor: Colors.grey,
                    textColor: Colors.black,
                    borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
