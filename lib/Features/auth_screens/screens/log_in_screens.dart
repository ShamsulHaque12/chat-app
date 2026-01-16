import 'package:chat_app/Features/bottom_nav_bar/screens/bottom_nav_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class LogInScreens extends StatelessWidget {
  const LogInScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Image.asset("assets/images/chat.png"),
              SizedBox(height: 20.h),
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Get.to(() => HomeScreen());
                    Get.to(()=>BottomNavBarScreen());
                  },
                  child: Container(
                    height: 50.h,
                    width: 70.w,
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 20, 168, 99),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/google.svg",
                      height: 50.h,
                      width: 50.w,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Divider(
                color: const Color.fromARGB(255, 10, 143, 54),
                radius: BorderRadius.all(Radius.circular(10.r)),
                thickness: 30.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
