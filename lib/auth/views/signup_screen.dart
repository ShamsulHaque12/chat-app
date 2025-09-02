import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/signup_controller.dart';
import 'login_screen.dart';
import 'otp_screen.dart';

class SignupScreen extends StatelessWidget {
  final SignupController controller = Get.put(SignupController());
  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all( 15),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/chat.png"),
              SizedBox(height: 20,),
              TextFormField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  hintText: "Name",
                  labelText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Obx( () =>
                  TextFormField(
                    controller: controller.passwordController,
                    obscureText: !controller.isPasswordVisible.value,
                    decoration: InputDecoration(
                      hintText: "Password",
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: IconButton(
                          icon: Icon(controller.isPasswordVisible.value ?
                          Icons.visibility : Icons.visibility_off
                          ),
                          onPressed: () {
                            controller.togglePasswordVisibility();
                          }
                      ),
                    ),
                  ),
              ),
              SizedBox(height: 10,),
              Obx( () =>
                  TextFormField(
                    controller: controller.confirmPasswordController,
                    obscureText: !controller.isConfirmPasswordVisible.value,
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      labelText: "Confirm Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: IconButton(
                          icon: Icon(controller.isConfirmPasswordVisible.value ?
                          Icons.visibility : Icons.visibility_off
                          ),
                          onPressed: () {
                            controller.toggleConfirmPasswordVisibility();
                          }
                      ),
                    ),
                  ),
              ),
              SizedBox(height: 30,),
              Center(
                child: ElevatedButton(onPressed: (){
                  controller.registerUser();
                },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF7B2CFA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    child: Text("Signed Up",style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),)),
              ),
              SizedBox(height: 20,),
              Center(
                child: Text("OR",style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: (){
                  Get.to(()=>LoginScreen());
                },
                child: Center(
                  child: Text("Sign In",style: TextStyle(
                    color: Colors.red,
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
