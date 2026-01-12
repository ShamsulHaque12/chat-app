import 'package:chat_app/core/custom_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
        automaticallyImplyLeading: false,

        title: Row(
          children: [
            CircleAvatar(
              radius: 21.r,
              backgroundImage: NetworkImage(
                "https://i.pravatar.cc/150",
              ),
            ),
          ],
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                // notification action
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.notification_important_rounded,
                  color: Colors.green,
                ),
              ),
            ),
          ),
        ],
      ),

      body: Padding(
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
                  Obx(() {
                    if (controller.isLoading.value) {
                      return Center(
                        child: SpinKitWave(color: Colors.green, size: 40.0),
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
                                    ),
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
                  }),
                  // SizedBox(height: 8.h),
                  CustomTextField(
                    height: 30.h,
                    textEditingController: controller.searchController,
                    fillColor: Colors.white,
                    hintText: 'Search',
                    hintTextColor: Colors.grey,
                    textColor: Colors.black,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // tab 1
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.changeTab(0),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        decoration: BoxDecoration(
                          color: controller.selectedIndex.value == 0
                              ? Colors.green
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "All Chats",
                          style: TextStyle(
                            color: controller.selectedIndex.value == 0
                                ? Colors.white
                                : Colors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 10.w),

                  // tab 2
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.changeTab(1),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        decoration: BoxDecoration(
                          color: controller.selectedIndex.value == 1
                              ? Colors.green
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Unread",
                          style: TextStyle(
                            color: controller.selectedIndex.value == 1
                                ? Colors.white
                                : Colors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
            SizedBox(height: 10.h),
            Expanded(
              child: Obx(() {
                return controller.screens[controller.selectedIndex.value];
              }),
            ),
          ],
        ),
      ),
    );
  }
}
