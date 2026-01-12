// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import '../../utills/api_config.dart';
// import '../views/otp_screen.dart';

// class SignupController extends GetxController {
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();

//   var isLoading = false.obs;
//   var isPasswordVisible = false.obs;
//   var isConfirmPasswordVisible = false.obs;

//   void togglePasswordVisibility() {
//     isPasswordVisible.value = !isPasswordVisible.value;
//   }

//   void toggleConfirmPasswordVisibility() {
//     isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
//   }

//   // Register user
//  Future<void> registerUser() async {
//     String name = nameController.text.trim();
//     String email = emailController.text.trim();
//     String password = passwordController.text.trim();
//     String confirmPassword = confirmPasswordController.text.trim();

//     if(name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty){
//       Get.snackbar("Error", "All fields are required");
//       return;
//     }
//     if(password!= confirmPassword){
//       Get.snackbar("Error", "Password does not match");
//       return;
//     }
//     try{
//       isLoading.value = true;
//       log("Register Api Request ===>${ApiConfig.register}");
//       log(
//         "Register API Request -> Body : "
//             "${jsonEncode({"fullName": name, "email": email, "password": password, "confirmPassword": confirmPassword})}",
//       );
//       final response = await http.post(
//         Uri.parse(ApiConfig.register),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode({
//           "fullName": name,
//           "email": email,
//           "password": password,
//           "confirmPassword": confirmPassword,
//         }),
//       );
//       log("Register Api Response ===>${response.body}");
//       if(response.statusCode == 200 || response.statusCode == 201){
//         final data = jsonDecode(response.body);
//         if (data["success"] == true) {
//           final otp = data["otp"]?.toString() ?? '';
//           Get.snackbar(
//             "Success",
//             data["message"] ?? "Registration successful!",
//             backgroundColor: Colors.green,
//             colorText: Colors.white,
//             barBlur: 1.5,
//           );
//           Get.to(() => OtpScreen(email: email, otp: otp));
//         } else {
//           Get.snackbar(
//             "Failed",
//             data["message"] ?? "Registration failed!",
//             backgroundColor: Colors.red,
//             colorText: Colors.white,
//             barBlur: 1.5,
//           );
//         }
//       }
//     }catch(e){
//       log(e.toString());
//     }finally{
//       isLoading.value = false;
//     }
//  }

//   @override
//   void dispose() {
//     nameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     super.dispose();
//   }
// }
