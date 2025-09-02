import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:chat_app/auth/views/login_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../utills/api_config.dart';

class OtpController extends GetxController {
  var otp = "".obs;
  var timer = 60.obs;
  Timer? countdown;
  var isLoading = false.obs;

  @override
  void onInit (){
    super.onInit();
    startTimer();
  }
  void startTimer() {
    timer.value = 60;
    countdown?.cancel();
    countdown = Timer.periodic(const Duration(seconds: 1), (t) {
      if (timer.value > 0) {
        timer.value--;
      } else {
        t.cancel();
      }
    });
  }
  //.........otpSubmitted...................
  Future<void> otpSubmitted(String email, String otp) async {
    try{
      isLoading.value = true;
      log("Otp Api Request ===>${ApiConfig.verify}");
      log("Otp API Request -> Body : ${jsonEncode({"email": email, "otp": otp})}");

      final response = await http.post(
        Uri.parse(ApiConfig.verify),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "email": email,
          "otp": otp,
        }),
      );
      log("Otp Api Response ===>${response.body}");

      if(response.statusCode == 200 || response.statusCode == 201){
        final data = jsonDecode(response.body);
        if (data["success"] == true) {
         Get.snackbar("Success", data["message"] ?? "OTP verified successfully");
         log("OTP verified successfully");
         Get.offAll(()=>LoginScreen());
        }
        else{
          Get.snackbar("Failed", data["message"] ?? "OTP verification failed");
          log("OTP verification failed");
        }
      }
    }catch(e){
      log(e.toString());
    }finally{
      isLoading.value = false;
      EasyLoading.dismiss();
    }
  }

  @override
  void onClose() {
    countdown?.cancel();
    super.onClose();
  }

}
