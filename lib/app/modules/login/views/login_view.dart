
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold/app/core/custom_validation.dart';
import 'package:gold/app/core/url.dart';
import 'package:gold/app/data/constant/assets_constant.dart';
import 'package:gold/app/routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          child: Form(
            key: controller.loginFormKey,
            child: Column(
              children: [
                // Top curved section with logo
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    const SizedBox(width: 20),
                    Column(
                      children: [
                        const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C2C2C),
                          ),
                        ),
                        const SizedBox(height: 5),

                        // Welcome subtitle
                        Text(
                          "welcome",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                // Login title

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

                // Password field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GetBuilder(
                    init: controller,
                    builder: (context) {
                      return TextFormField(
                        controller: controller.mPinEditingController,
                        obscureText: controller.isPasswordVisible,
                        validator:
                            (value) =>
                                CustomValidation.validateMpin(name: value!),
                        decoration: InputDecoration(
                          hintText: "Password",
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              controller.togglePasswordVisibility();
                            },
                          ),
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
                      );
                    },
                  ),
                ),

                // Forgot password
                Padding(
                  padding: const EdgeInsets.only(right: 30, top: 8),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Login button
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
                      if (controller.loginFormKey.currentState!.validate()) {
                        controller.userLogin();
                      }
                    },
                    child: const Text(
                      "LOGIN",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // New registration button
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
                      Get.offAllNamed(Routes.REGISTER);
                    },
                    child: const Text(
                      "New Registration",
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
