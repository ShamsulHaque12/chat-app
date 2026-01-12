// import 'package:chat_app/auth/controller/signup_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:pinput/pinput.dart';

// import '../controller/otp_controller.dart';

// class OtpScreen extends StatelessWidget {
//   final OtpController controller = Get.put(OtpController());
//   final SignupController signupController = Get.put(SignupController());
//   final String email;
//   final String otp;
//   OtpScreen({super.key, required this.email, required this.otp});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("OTP Screen"),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(15),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: Column(
//                 children: [
//                   Text("Enter Otp Sent your Gmail",style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 22,
//                     fontWeight: FontWeight.w400,
//                   ),),
//                   SizedBox(height: 8,),
//                   Text(signupController.emailController.text.toString(),style: TextStyle(
//                     color: Colors.blue,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w500,
//                   ),),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20,),
//             Pinput(
//               length: 6,
//               onChanged: (value) => controller.otp.value = value,
//               defaultPinTheme: PinTheme(
//                 width: 50.w,
//                 height: 50.h,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Color(0xFF848484)),
//                   borderRadius: BorderRadius.circular(8.r),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20,),
//             Center(
//               child: ElevatedButton(onPressed: (){
//                 if (controller.otp.value.length != 6) {
//                   Get.snackbar("Error", "Please enter a 6-digit OTP");
//                   return;
//                 }
//                 controller.otpSubmitted( email,controller.otp.value);
//               },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFF7B2CFA),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                   ),
//                   child: Text("Submitted",style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400,
//                   ),)),
//             ),
//             SizedBox(height: 20,),
//             GestureDetector(
//               onTap: (){},
//               child: Center(
//                 child: Text("Resend OTP (00 : ${controller.timer.value})",style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 22,
//                   fontWeight: FontWeight.w400,
//                 ),),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
