import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../controller/signup_controller.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  final SignupController controller = Get.put(SignupController());

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/chat.png"),
              const SizedBox(height: 20),

              // Name field
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
              const SizedBox(height: 10),

              // Email field
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
              const SizedBox(height: 10),

              // Password field
              Obx(
                    () => TextFormField(
                  controller: controller.passwordController,
                  obscureText: !controller.isPasswordVisible.value,
                  decoration: InputDecoration(
                    hintText: "Password",
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Confirm Password
              Obx(
                    () => TextFormField(
                  controller: controller.confirmPasswordController,
                  obscureText: !controller.isConfirmPasswordVisible.value,
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    labelText: "Confirm Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isConfirmPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: controller.toggleConfirmPasswordVisibility,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Sign Up Button / Loader
              Obx(() {
                return controller.isLoading.value
                    ? Center(
                  child: SpinKitWave(
                    color: Colors.green,
                  ),
                )
                    : Center(
                  child: ElevatedButton(
                    onPressed: controller.registerUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7B2CFA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 20),

              // OR divider
              const Center(
                child: Text(
                  "OR",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Go to Login
              GestureDetector(
                onTap: () => Get.to(() => LoginScreen()),
                child: const Center(
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
