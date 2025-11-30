import 'package:chat_app/core/custom_widgets/custom_button.dart';
import 'package:chat_app/core/custom_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_images.dart';
import '../controller/edit_profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  final EditProfileController controller = Get.put(EditProfileController());
  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  Obx(
                    () => CircleAvatar(
                      radius: 60.r,
                      backgroundImage: controller.profileImage.value != null
                          ? FileImage(controller.profileImage.value!)
                                as ImageProvider
                          : AssetImage(AppImages.profileLogo),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        Get.bottomSheet(
                          Container(
                            color: isDark ? Colors.grey[900] : Colors.white,
                            padding: EdgeInsets.all(15.w),
                            child: Wrap(
                              children: [
                                ListTile(
                                  leading: Icon(
                                    Icons.photo_library,
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                  title: Text(
                                    'Gallery',
                                    style: TextStyle(
                                      color: isDark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  onTap: () {
                                    controller.pickFromGallery();
                                    Get.back();
                                  },
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.camera_alt,
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                  title: Text(
                                    'Camera',
                                    style: TextStyle(
                                      color: isDark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  onTap: () {
                                    controller.pickFromCamera();
                                    Get.back();
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 15.r,
                        backgroundColor: Colors.green,
                        child: Icon(
                          Icons.edit,
                          size: 18.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            CustomTextField(
              titleText: "Enter Name",
              textEditingController: controller.nameController,
              fillColor: Colors.transparent,
              hintText: 'Name',
              hintTextColor: isDark ? Colors.white : Colors.grey,
              textColor: isDark ? Colors.white : Colors.black,
              borderSide: BorderSide(color: Colors.green, width: 1.0),
            ),
            SizedBox(height: 10.h),
            CustomTextField(
              titleText: "Enter Email",
              textEditingController: controller.emailController,
              fillColor: Colors.transparent,
              hintText: 'email',
              hintTextColor: isDark ? Colors.white : Colors.grey,
              textColor: isDark ? Colors.white : Colors.black,
              borderSide: BorderSide(color: Colors.green, width: 1.0),
            ),
            SizedBox(height: 10.h),
            CustomTextField(
              titleText: "Enter password",
              textEditingController: controller.passwordController,
              fillColor: Colors.transparent,
              hintText: 'password',
              hintTextColor: isDark ? Colors.white : Colors.grey,
              textColor: isDark ? Colors.white : Colors.black,
              isPassword: true,
              borderSide: BorderSide(color: Colors.green, width: 1.0),
            ),
            SizedBox(height: 20.h),
            CustomButton(
              text: "Update",
              onTap: () {
                // Handle update button press
              },
              backgroundColor: Colors.green,
              textColor: Colors.white,
              radius: 10.r,
              borderColor: Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
