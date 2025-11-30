import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../core/custom_widgets/custom_button.dart';
import '../../../core/custom_widgets/custom_text_field.dart';
import '../controller/change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  final ChangePasswordController controller = Get.put(
    ChangePasswordController(),
  );
  ChangePasswordScreen({super.key});

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
          child: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Change Password',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              titleText: "Enter Old password",
              textEditingController: controller.oldPasswordController,
              fillColor: Colors.transparent,
              hintText: 'password',
              hintTextColor: isDark ? Colors.white : Colors.grey,
              textColor: isDark ? Colors.white : Colors.black,
              isPassword: true,
              borderSide: BorderSide(color: Colors.green, width: 1.0),
            ),
            SizedBox(height: 10.h),
            CustomTextField(
              titleText: "Enter New password",
              textEditingController: controller.passwordController,
              fillColor: Colors.transparent,
              hintText: 'password',
              hintTextColor: isDark ? Colors.white : Colors.grey,
              textColor: isDark ? Colors.white : Colors.black,
              isPassword: true,
              borderSide: BorderSide(color: Colors.green, width: 1.0),
            ),
            SizedBox(height: 10.h),
            CustomTextField(
              titleText: "Enter Confirm password",
              textEditingController: controller.confirmPasswordController,
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
          ]
        ),
      ),
    );
  }
}
