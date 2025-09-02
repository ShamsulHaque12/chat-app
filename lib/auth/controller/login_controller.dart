import 'dart:convert';
import 'dart:developer';

import 'package:chat_app/core/services/shared_prefarence_help.dart';
import 'package:chat_app/home_screens/view/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../utills/api_config.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isLoading = false.obs;

  var isPasswordVisible = false.obs;
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  //...........Login //...................
  Future<void> loginUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if(email.isEmpty || password.isEmpty){
      Get.snackbar("Error", "All fields are required");
      return;
    }
    try{
      isLoading.value = true;
      log("Login Api Request ===>${ApiConfig.login}");
      log("Login API Request -> Body : ${jsonEncode({"email": email, "password": password})}");
      final NetworkResponse response = await NetworkCaller().postRequest(url: ApiConfig.login,body: {
        "email": email,
        "password": password,
      });
      log("Login Api Response ===>${response.responseData}");
      if(response.isSuccess){
        final data = response.responseData;
          Get.snackbar(
            "Success",
            data!["message"] ?? "Login successful!",
            backgroundColor: Colors.green,
            colorText: Colors.white,
            barBlur: 1.5,
          );
          Get.offAll(()=>HomeScreen());
      }
      else{
        Get.snackbar(
          "Error",
          response.errorMessage,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          barBlur: 1.5,
        );
      }
    }catch(e){
      log(e.toString());
    }finally{
      isLoading.value = false;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}