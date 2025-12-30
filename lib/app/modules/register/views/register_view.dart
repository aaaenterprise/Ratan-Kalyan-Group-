
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold/app/core/custom_validation.dart';
import 'package:gold/app/core/url.dart' show UrlLauncher;
import 'package:gold/app/data/constant/assets_constant.dart';
import 'package:gold/app/core/app_color.dart';

import 'package:gold/app/routes/app_pages.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
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
                          gradient: AppColors.primaryGradient,
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
                              color: AppColors.textOnPrimary,
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
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 5),

                        // Welcome subtitle
                        const Text(
                          "Welcome to play",
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.textSecondary,
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
                      hintStyle: const TextStyle(color: AppColors.textTertiary),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: AppColors.accent, width: 2),
                      ),
                      filled: true,
                      fillColor: AppColors.cardBackground,
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
                      hintStyle: const TextStyle(color: AppColors.textTertiary),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: AppColors.accent, width: 2),
                      ),
                      filled: true,
                      fillColor: AppColors.cardBackground,
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
                      hintStyle: const TextStyle(color: AppColors.textTertiary),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: AppColors.accent, width: 2),
                      ),
                      filled: true,
                      fillColor: AppColors.cardBackground,
                      counterText: "", // Hide character counter
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Register button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
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
                          color: AppColors.textOnPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
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
                      side: const BorderSide(color: AppColors.primary, width: 2),
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
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
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
                      color: AppColors.accent,
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
