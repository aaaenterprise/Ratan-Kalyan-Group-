import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold/app/core/custom_validation.dart';
import 'package:gold/app/core/app_color.dart';
import 'package:gold/app/core/app_color.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: const AppColors.primary,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24,
          ),
        ),
        title: const Text(
          "My Profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Manage Profile Section
            _buildManageProfileSection(),
            
            const SizedBox(height: 30),
            
            // Change Password Section
            _buildChangePasswordSection(),
          ],
        ),
      ),
    );
  }

  // Manage Profile Section
  Widget _buildManageProfileSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Manage profile",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 15),
        
        // Name Field (Read-only)
        _buildReadOnlyField(
          value: controller.userController.userModel?.name ?? "User",
        ),
        
        const SizedBox(height: 15),
        
        // Phone Field (Read-only)
        _buildReadOnlyField(
          value: controller.userController.userModel?.phone ?? "",
        ),
        
        const SizedBox(height: 20),
        
        // // Update Profile Button (Disabled)
        // _buildButton(
        //   label: "Update Profile",
        //   onPressed: () {
        //     // Show message that profile info cannot be changed
        //     Get.snackbar(
        //       "Info", 
        //       "Profile information cannot be modified",
        //       backgroundColor: Colors.orange[100],
        //       colorText: Colors.orange[800],
        //     );
        //   },
        //   isEnabled: false,
        // ),
      ],
    );
  }

  // Change Password Section
  Widget _buildChangePasswordSection() {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Change Password",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 15),
          
          // Confirm Password Field
          _buildPasswordField(
            controller: controller.oldPasswordController,
            hintText: "Old Password",
            validator: (value) => CustomValidation.validateMpin(
              name: controller.oldPasswordController.text,
            ),
          ),
          const SizedBox(height: 15),
          
          // New Password Field
          _buildPasswordField(
            controller: controller.newPasswordController,
            hintText: "New Password",
            validator: (value) => CustomValidation.validateMpin(
              name: controller.newPasswordController.text,
            ),
          ),
          
          
          
          const SizedBox(height: 20),
          
          // Update Password Button
          _buildButton(
            label: "Update Password",
            onPressed: () {
              if (controller.formKey.currentState!.validate()) {
                controller.changePassword();
              }
            },
            isEnabled: true,
          ),
        ],
      ),
    );
  }

  // Read-only field for profile info
  Widget _buildReadOnlyField({required String value}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColors.border!),
      ),
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 16,
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  // Password input field
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      style: const TextStyle(
        fontSize: 16,
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 16,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: AppColors.border!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: AppColors.border!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
      ),
      validator: validator,
    );
  }

  // Button widget
  Widget _buildButton({
    required String label,
    required VoidCallback onPressed,
    required bool isEnabled,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? const AppColors.primary : AppColors.textSecondary,
          disabledBackgroundColor: AppColors.textSecondary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}