import 'package:chat_app/Features/profile_screens/screens/theme_mode_screen.dart';
import 'package:chat_app/core/themes/app_icons.dart';
import 'package:chat_app/core/themes/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../controller/profile_controller.dart';
import 'change_password_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        title: Text(
          "Profile",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 25.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60.r,
                backgroundImage: AssetImage(AppImages.profileLogo),
              ),
            ),
            SizedBox(height: 10.h),
            Center(
              child: Text(
                "Shamsul Haque",
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Center(
              child: Text(
                "xyz@gmail.com",
                style: TextStyle(
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade400,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            ProfileItem(
              label: 'Edit Profile',
              image: AppIcons.edit,
              imageIcone: AppIcons.arrow,
              onPressed: () {
                Get.to(()=>EditProfileScreen());
              },
            ),
            SizedBox(height: 10.h),
            ProfileItem(
              label: 'Change Password',
              image: AppIcons.lock,
              imageIcone: AppIcons.arrow,
              onPressed: () {
                Get.to(()=>ChangePasswordScreen());
              },
            ),
            SizedBox(height: 10.h),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade800 : Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                      color: Colors.green,
                      width: 2
                  )
              ),
              child: Row(
                children: [
                  SvgPicture.asset(AppIcons.notification,height: 20.h,width: 20.w,color: Colors.green,),
                  SizedBox(width: 10.w),
                  Text("Notification",style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),),
                  Spacer(),
                  Obx(
                    (){
                     return Switch(
                        value: controller.notification.value,
                        onChanged: controller.notificationSwitch,
                        activeColor: Colors.green,
                      );
                    },
                  )
                ],
              ),
            ),
            SizedBox(height: 10.h),
            ProfileItem(
              label: 'Theme Mode',
              image: AppIcons.theme,
              imageIcone: AppIcons.arrow,
              onPressed: () {
                Get.to(()=>ThemeModeScreen());
              },
            ),
            SizedBox(height: 10.h),
            ProfileItem(
              label: 'Delete Account',
              image: AppIcons.delete,
              imageIcone: AppIcons.arrow,
              onPressed: () {
                _showDeleteDialog(context);
              },
            ),
            SizedBox(height: 10.h),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                _showSuccessDialog(context);
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: isDark ? Colors.grey.shade800 : Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                        color: Colors.red,
                        width: 2
                    )
                ),
                child: Row(
                  children: [
                    Image.asset(AppIcons.logout,height: 25.h,width: 25.w,),
                    SizedBox(width: 10.w),
                    Text("Logout",style: TextStyle(
                      color: Colors.red,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),),
                    Spacer(),
                    SvgPicture.asset(AppIcons.arrow,height: 25.h,width: 25.w,color: Colors.red,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _showSuccessDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDark ? Colors.grey.shade800 : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AppIcons.logout,
                width: 40.w,
                height: 40.h,
                color: Colors.red,
              ),
              SizedBox(height: 10.h),
              Text(
                "Logout!",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "Are you sure you want to logout from the application?!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp,color: isDark ? Colors.white : Colors.black),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        side: BorderSide(
                          color: Colors.green,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // await SharedPreferencesHelper.logout();
                      // Get.offAllNamed(Routes.AUTH_LOGIN_SCREEN);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text("Yes, Logout"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
  void _showDeleteDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDark ? Colors.grey.shade800 : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AppIcons.logout,
                width: 40.w,
                height: 40.h,
                color: Colors.red,
              ),
              SizedBox(height: 10.h),
              Text(
                "Delete!",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "Are you sure you want to Delete from the application?!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp, color: isDark ? Colors.white : Colors.black),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        side: BorderSide(
                          color: Colors.green,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // await SharedPreferencesHelper.logout();
                      // Get.offAllNamed(Routes.AUTH_LOGIN_SCREEN);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text("Yes, Delete"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

}

class ProfileItem extends StatelessWidget {
  final String label;
  final String image;
  final String imageIcone;
  final VoidCallback? onPressed;
  const ProfileItem({
    super.key,
    required this.label,
    required this.image,
    required this.imageIcone,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey.shade800 : Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: Colors.green,
            width: 2
          )
        ),
        child: Row(
          children: [
            SvgPicture.asset(image,height: 20.h,width: 20.w,color: Colors.green,),
            SizedBox(width: 10.w),
            Text(label,style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),),
            Spacer(),
            SvgPicture.asset(imageIcone,height: 25.h,width: 25.w,),
          ],
        ),
      )
    );
  }
}
