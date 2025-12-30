
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold/app/core/custom_validation.dart';
import 'package:gold/app/core/url.dart' show UrlLauncher;
import 'package:gold/app/data/constant/assets_constant.dart';

import 'package:gold/app/routes/app_pages.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          child: Form(
            key: controller.signupFormKey,
            child: Column(
              children: [
                // Top curved section with logo
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        alignment: Alignment.center,
                        width: 220,
                        height: 220,
                        decoration: const BoxDecoration(
                          color: Color(0xFF4B0E57), // Purple shade
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(180),
                          ),
                        ),
                        child: Image.asset(
                          AssetsConstant.logo, // Replace with your logo asset
                          height: 120,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.account_circle,
                              color: Colors.white,
                              size: 100,
                            );
                          },
                        ),
                      ),
                    ),
                    //  const SizedBox(width: 20),
                    // Register title
                    Column(
                      children: [
                        const Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C2C2C),
                          ),
                        ),
                        const SizedBox(height: 5),

                        // Welcome subtitle
                        Text(
                          "Welcome to play",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // Main content area
                const SizedBox(height: 30),

                // Full Name field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    controller: controller.nameEditingController,
                    validator:
                        (value) => CustomValidation.validateName(name: value!),
                    maxLength: 25,
                    decoration: InputDecoration(
                      hintText: "Enter your full name",
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      counterText: "", // Hide character counter
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // Mobile number field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    controller: controller.mobileEditingController,
                    keyboardType: TextInputType.phone,
                    validator:
                        (value) =>
                            CustomValidation.phoneValidator(phone: value!),
                    decoration: InputDecoration(
                      hintText: "Enter your mobile number",
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // MPin field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    controller: controller.mPinEditingController,
                    obscureText: true,
                    validator:
                        (value) => CustomValidation.validateMpin(name: value!),
                    maxLength: 25,
                    // keyboardType: TextInputType.pass,
                    decoration: InputDecoration(
                      hintText: "Create your Password",
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      counterText: "", // Hide character counter
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Register button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4B0E57),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      if (controller.signupFormKey.currentState!.validate()) {
                        controller.userRegister();
                      }
                    },
                    child: const Text(
                      "REGISTER",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // Already have account button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF4B0E57)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      Get.offAllNamed(Routes.LOGIN);
                    },
                    child: const Text(
                      "Already have an account? Login",
                      style: TextStyle(fontSize: 16, color: Color(0xFF4B0E57)),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                TextButton(
                  onPressed: () {
                    String url =
                        "whatsapp://send?phone=${controller.userController.setting?.whatsappSupport}&text=";
                    UrlLauncher.launchUrl(url);
                  },
                  child: const Text(
                    "Contact Us With",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF4B0E57),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
