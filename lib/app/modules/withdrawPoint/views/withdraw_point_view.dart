import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gold/app/core/custom_validation.dart';
import 'package:gold/app/core/widgets/widgets.dart';
import 'package:gold/app/core/app_color.dart';
import 'package:gold/app/routes/app_pages.dart';
import 'package:gold/app/core/app_color.dart';

import '../controllers/withdraw_point_controller.dart';

class WithdrawPointView extends GetView<WithdrawPointController> {
  const WithdrawPointView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Get.offAllNamed(Routes.HOME);
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F3F0), // Light cream background
        appBar: AppBar(
          backgroundColor: const AppColors.primary, // Purple color
          elevation: 0,
          leading: IconButton(
            onPressed: () => Get.offAllNamed(Routes.HOME),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24,
            ),
          ),
          title: const Text(
            'Withdraw Coins',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: false,
        ),
        body: _buildContent(context),
      ),
    );
  }
  
  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            // Amount Input Field
            _buildAmountInput(),
            
            const SizedBox(height: 16),
            
            // Payment Method Field (Static Paytm)
            _buildPaymentMethodField(),
            
            const SizedBox(height: 16),
            
            // UPI Number Input Field
            _buildUpiNumberInput(),
            
            const SizedBox(height: 30),
            
            // Request Withdraw Button
            _buildWithdrawButton(),
            
            const SizedBox(height: 20),
            
            
          ],
        ),
      ),
    );
  }
  
  Widget _buildAmountInput() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextFormField(
          controller: controller.amountEditingController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.textPrimary,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Enter Amount",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "Amount Required";
            } else if (controller.userController.setting?.minimumWithdraw != null &&
                       int.parse(value) < controller.userController.setting!.minimumWithdraw!) {
              return "Withdraw minimum ${controller.userController.setting!.minimumWithdraw}";
            }
            return null;
          },
        ),
      ),
    );
  }
  
  Widget _buildPaymentMethodField() {
    return GetBuilder<WithdrawPointController>(
      builder: (controller) {
        return Container(
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: controller.selectedPayment.isEmpty ? null : controller.selectedPayment,
                hint: const Text(
                  "Select Payment Method",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textPrimary,
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Paytm',
                    child: Text('Paytm'),
                  ),
                  DropdownMenuItem(
                    value: 'GPay',
                    child: Text('Google Pay'),
                  ),
                  DropdownMenuItem(
                    value: 'Phonepe',
                    child: Text('PhonePe'),
                  ),
                ],
                onChanged: (String? value) {
                  if (value != null) {
                    controller.selectedPayment = value;
                    controller.update();
                  }
                },
              ),
            ),
          ),
        );
      }
    );
  }
  
  Widget _buildUpiNumberInput() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextFormField(
          controller: controller.upiNumberEditingController,
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.textPrimary,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Paytm number",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          validator: (value) => CustomValidation.phoneValidator(phone: value ?? ''),
        ),
      ),
    );
  }
  
  Widget _buildWithdrawButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          // Check if payment method is selected
          if (controller.selectedPayment.isEmpty) {
            CustomWidget.showSnackBar("Please select a payment method");
            return;
          }
          
          // Check withdrawal time if setting exists
          if (controller.userController.setting != null &&
              !controller.userController.setting!.isCurrentTimeBetweenWithdrawTimes()) {
            CustomWidget.showSnackBar(
                "Withdraw allowed only between ${controller.userController.setting!.withdrawOpenTime} To ${controller.userController.setting!.withdrawCloseTime}");
            return;
          }
          
          if (controller.formKey.currentState!.validate()) {
            controller.withdrawPoint();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Request Withdraw',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}