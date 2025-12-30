import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_upi_india/flutter_upi_india.dart';
import 'package:get/get.dart';
import 'package:gold/app/core/url.dart';
import 'package:gold/app/core/widgets/widgets.dart';
import 'package:gold/app/core/app_color.dart';
import 'package:gold/app/routes/app_pages.dart';


import '../controllers/add_point_controller.dart';

class AddPointView extends GetView<AddPointController> {
  const AddPointView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Get.offAllNamed(Routes.HOME);
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: const Color(0xFFF5F3F0),
          appBar: AppBar(
            backgroundColor: const AppColors.primary,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Get.offAllNamed(Routes.HOME),
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
            ),
            title: const Text(
              'Deposit',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            centerTitle: false,
            bottom: const TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white60,
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              unselectedLabelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              tabs: [
                Tab(
                  icon: Icon(Icons.account_balance_wallet_outlined),
                  text: 'UPI',
                ),
                Tab(icon: Icon(Icons.qr_code_scanner), text: 'QR Code'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildUPIContent(context, controller),
              _QRCodeTab(controller: controller),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUPIContent(BuildContext context, AddPointController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAmountInput(),
            const SizedBox(height: 8),
            Text(
              '*Please enter minimum ${controller.userController.setting?.minimumDeposit} Rs',
              style: const TextStyle(color: AppColors.error, fontSize: 14),
            ),
            const SizedBox(height: 20),
            _buildAmountButtons(),
            const SizedBox(height: 30),
            _buildPaymentMethods(),
            const Spacer(),
            _buildProceedButton(),
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
          style: const TextStyle(fontSize: 16, color: Colors.black),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Enter Points",
            hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          validator: (value) {
            if (controller.amountEditingController.text.isEmpty) {
              return "Enter Amount";
            } else if (int.parse(controller.amountEditingController.text) <
                (controller.userController.setting?.minimumDeposit ?? 0)) {
              return "Minimum amount is ${controller.userController.setting?.minimumDeposit} Rs";
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildAmountButtons() {
    return Column(
      children: [
        Row(
          children: [
            _buildAmountButton("200"),
            const SizedBox(width: 8),
            _buildAmountButton("500"),
            const SizedBox(width: 8),
            _buildAmountButton("1000"),
            const SizedBox(width: 8),
            _buildAmountButton("1500"),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildAmountButton("2000"),
            const SizedBox(width: 8),
            _buildAmountButton("5000"),
            const SizedBox(width: 8),
            _buildAmountButton("10000"),
            const SizedBox(width: 8),
            _buildAmountButton("20000"),
          ],
        ),
      ],
    );
  }

  Widget _buildAmountButton(String amount) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.amountEditingController.text = amount;
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: const AppColors.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              '₹ $amount',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return GetBuilder<AddPointController>(
      builder: (controller) {
        return Column(
          children: [
            _buildPaymentOption(
              title: 'Google Pay',
              icon: Icons.payment,
              value: 'googlepay',
              groupValue: controller.selectedPaymentMethod,
              onChanged: (value) {
                controller.selectedPaymentMethod = value!;
                controller.update();
              },
            ),
            const SizedBox(height: 16),
            _buildPaymentOption(
              title: 'Phone Pay',
              icon: Icons.phone_android,
              value: 'phonepe',
              groupValue: controller.selectedPaymentMethod,
              onChanged: (value) {
                controller.selectedPaymentMethod = value!;
                controller.update();
              },
            ),
            const SizedBox(height: 16),
            _buildPaymentOption(
              title: 'Paytm',
              icon: Icons.account_balance_wallet,
              value: 'paytm',
              groupValue: controller.selectedPaymentMethod,
              onChanged: (value) {
                controller.selectedPaymentMethod = value!;
                controller.update();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildPaymentOption({
    required String title,
    required IconData icon,
    required String value,
    required String groupValue,
    required ValueChanged<String?> onChanged,
  }) {
    final bool isSelected = value == groupValue;

    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const AppColors.primary : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 24, color: const AppColors.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Radio<String>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor: const AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProceedButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          if (controller.formKey.currentState!.validate()) {
            if (controller.selectedPaymentMethod.isEmpty) {
              CustomWidget.showSnackBar("Please select a payment method");
              return;
            }
            _handlePayment();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const AppColors.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: const Text(
          'PROCEED TO PAYMENT',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _handlePayment() {
    ApplicationMeta? selectedApp;

    for (ApplicationMeta app in controller.apps) {
      final appName = app.upiApplication.appName.toLowerCase();
      if (controller.selectedPaymentMethod == 'googlepay' &&
          appName.contains('pay')) {
        selectedApp = app;
        break;
      } else if (controller.selectedPaymentMethod == 'phonepe' &&
          appName.contains('phonepe')) {
        selectedApp = app;
        break;
      } else if (controller.selectedPaymentMethod == 'paytm' &&
          appName.contains('paytm')) {
        selectedApp = app;
        break;
      }
    }

    if (selectedApp != null) {
      controller.startPaymentSession(selectedApp);
    } else {
      CustomWidget.showSnackBar("Selected payment app not found");
    }
  }
}

// QR Code Tab Widget
class _QRCodeTab extends StatefulWidget {
  final AddPointController controller;

  const _QRCodeTab({required this.controller});

  @override
  State<_QRCodeTab> createState() => _QRCodeTabState();
}

class _QRCodeTabState extends State<_QRCodeTab>
    with AutomaticKeepAliveClientMixin {
  bool isLoading = true;
  String? barcodeData;

  // TODO: Replace with actual values from settings/controller
  String get upiID =>
      widget.controller.userController.setting?.googlepayUpi ?? 'example@upi';
  String get payeeName => 'Kalki';
  String get whatsappNumber =>
      widget.controller.userController.setting?.whatsappSupport ??
      '919999999999';

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _loadBarcode();
    });
  }

  Future<void> _loadBarcode() async {
    setState(() => isLoading = true);

    final String upiDetails = "upi://pay?pa=$upiID&pn=$payeeName&cu=INR";

    barcodeData = Barcode.qrCode().toSvg(
      upiDetails,
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.width * 0.6,
    );

    setState(() => isLoading = false);
  }

  Future<void> _launchWhatsApp() async {
    final String message = Uri.encodeComponent(
      'Hi Admin, I have made a payment via QR code. Please confirm my deposit.',
    );

    String url = "whatsapp://send?phone=$whatsappNumber&text=$message";
    UrlLauncher.launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 20),

          // QR Code Container
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowMedium,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.qr_code_2, color: AppColors.primary, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Scan & Pay',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // QR Code
                if (isLoading)
                  const SizedBox(
                    height: 200,
                    width: 200,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                  )
                else if (barcodeData != null)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const AppColors.primary.withOpacity(0.3),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SvgPicture.string(
                      barcodeData!,
                      height: 200,
                      width: 200,
                    ),
                  ),

                const SizedBox(height: 16),

                // Payee Name
                Text(
                  payeeName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 4),

                // UPI ID
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.account_balance,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        upiID,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Instructions Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.warning.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.warning.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.orange.shade700,
                      size: 22,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'How to Pay',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.warningDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildInstructionStep(
                  number: '1',
                  text: 'Open any UPI app (GPay, PhonePe, Paytm)',
                ),
                _buildInstructionStep(
                  number: '2',
                  text: 'Scan the QR code above',
                ),
                _buildInstructionStep(
                  number: '3',
                  text: 'Enter the amount and complete payment',
                ),
                _buildInstructionStep(
                  number: '4',
                  text: 'Take a screenshot of the payment confirmation',
                ),
                _buildInstructionStep(
                  number: '5',
                  text: 'Contact Admin on WhatsApp for verification',
                  isLast: true,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // WhatsApp Contact Button
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton.icon(
              onPressed: _launchWhatsApp,
              icon: const Icon(Icons.chat, color: Colors.white, size: 24),
              label: const Text(
                'Contact Admin on WhatsApp',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF25D366), // WhatsApp green
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Copy UPI ID Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton.icon(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: upiID));
                CustomWidget.showSnackBar('UPI ID copied to clipboard');
              },
              icon: const Icon(Icons.copy, color: AppColors.primary, size: 20),
              label: const Text(
                'Copy UPI ID',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primary, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Note
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.error.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.error.shade200),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: AppColors.errorDark,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Points will be added only after admin verification. Please share payment proof on WhatsApp.',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.errorDark,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildInstructionStep({
    required String number,
    required String text,
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: Colors.orange.shade700,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade800,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_upi_india/flutter_upi_india.dart';
// import 'package:get/get.dart';
// import 'package:gold/app/core/widgets/widgets.dart';
// import 'package:gold/app/core/app_color.dart';
// import 'package:gold/app/routes/app_pages.dart';
import 'package:gold/app/core/app_color.dart';

// import '../controllers/add_point_controller.dart';

// class AddPointView extends GetView<AddPointController> {
//   const AddPointView({super.key});
  
//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       onPopInvoked: (didPop) {
//         Get.offAllNamed(Routes.HOME);
//       },
//       child: Scaffold(
//         backgroundColor: const Color(0xFFF5F3F0), // Light cream background
//         appBar: AppBar(
//           backgroundColor: const AppColors.primary, // Purple color
//           elevation: 0,
//           leading: IconButton(
//             onPressed: () => Get.offAllNamed(Routes.HOME),
//             icon: const Icon(
//               Icons.arrow_back,
//               color: Colors.white,
//               size: 24,
//             ),
//           ),
//           title: const Text(
//             'Deposit',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 20,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           centerTitle: false,
//         ),
//         body: _buildContent(context, controller),
//       ),
//     );
//   }
  
//   Widget _buildContent(BuildContext context, AddPointController controller) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Form(
//         key: controller.formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Amount Input Field
//             _buildAmountInput(),
            
//             const SizedBox(height: 8),
            
//             // Minimum amount validation text
//              Text(
//               '*Please enter minimum ${controller.userController.setting?.minimumDeposit} Rs',
//               style: TextStyle(
//                 color: AppColors.error,
//                 fontSize: 14,
//               ),
//             ),
            
//             const SizedBox(height: 20),
            
//             // Amount Selection Buttons
//             _buildAmountButtons(),
            
//             const SizedBox(height: 30),
            
//             // Payment Methods
//             _buildPaymentMethods(),
            
//             const Spacer(),
            
//             // Proceed Button
//             _buildProceedButton(),
            
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
  
//   Widget _buildAmountInput() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: TextFormField(
//           controller: controller.amountEditingController,
//           keyboardType: TextInputType.number,
//           inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//           style: const TextStyle(
//             fontSize: 16,
//             color: AppColors.textPrimary,
//           ),
//           decoration: const InputDecoration(
//             border: InputBorder.none,
//             hintText: "Enter Points",
//             hintStyle: TextStyle(
//               color: Colors.grey,
//               fontSize: 16,
//             ),
//           ),
//           validator: (value) {
//             if (controller.amountEditingController.text.isEmpty) {
//               return "Enter Amount";
//             } else if (int.parse(controller.amountEditingController.text) < (controller.userController.setting?.minimumDeposit??0)) {
//               return "Minimum amount is ${controller.userController.setting?.minimumDeposit} Rs";
//             }
//             return null;
//           },
//         ),
//       ),
//     );
//   }
  
//   Widget _buildAmountButtons() {
//     final List<String> amounts = [
//       "200", "500", "1000", "1500",
//       "2000", "5000", "10000", "20000"
//     ];
    
//     return Column(
//       children: [
//         // First row
//         Row(
//           children: [
//             _buildAmountButton("200"),
//             const SizedBox(width: 8),
//             _buildAmountButton("500"),
//             const SizedBox(width: 8),
//             _buildAmountButton("1000"),
//             const SizedBox(width: 8),
//             _buildAmountButton("1500"),
//           ],
//         ),
//         const SizedBox(height: 8),
//         // Second row
//         Row(
//           children: [
//             _buildAmountButton("2000"),
//             const SizedBox(width: 8),
//             _buildAmountButton("5000"),
//             const SizedBox(width: 8),
//             _buildAmountButton("10000"),
//             const SizedBox(width: 8),
//             _buildAmountButton("20000"),
//           ],
//         ),
//       ],
//     );
//   }
  
//   Widget _buildAmountButton(String amount) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           controller.amountEditingController.text = amount;
//         },
//         child: Container(
//           height: 50,
//           decoration: BoxDecoration(
//             color: const AppColors.primary,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Center(
//             child: Text(
//               '₹ $amount',
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
  
//   Widget _buildPaymentMethods() {
//     return GetBuilder<AddPointController>(
//       builder: (controller) {
//         return Column(
//           children: [
//             _buildPaymentOption(
//               title: 'Google Pay',
//               icon: Icons.payment,
//               value: 'googlepay',
//               groupValue: controller.selectedPaymentMethod,
//               onChanged: (value) {
//                 controller.selectedPaymentMethod = value!;
//                 controller.update();
//               },
//             ),
//             const SizedBox(height: 16),
//             _buildPaymentOption(
//               title: 'Phone Pay',
//               icon: Icons.phone_android,
//               value: 'phonepe',
//               groupValue: controller.selectedPaymentMethod,
//               onChanged: (value) {
//                 controller.selectedPaymentMethod = value!;
//                 controller.update();
//               },
//             ),
//             const SizedBox(height: 16),
//             _buildPaymentOption(
//               title: 'Paytm',
//               icon: Icons.account_balance_wallet,
//               value: 'paytm',
//               groupValue: controller.selectedPaymentMethod,
//               onChanged: (value) {
//                 controller.selectedPaymentMethod = value!;
//                 controller.update();
//               },
//             ),
//           ],
//         );
//       }
//     );
//   }
  
//   Widget _buildPaymentOption({
//     required String title,
//     required IconData icon,
//     required String value,
//     required String groupValue,
//     required ValueChanged<String?> onChanged,
//   }) {
//     final bool isSelected = value == groupValue;
    
//     return GestureDetector(
//       onTap: () => onChanged(value),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: Colors.grey.shade300),
//         ),
//         child: Row(
//           children: [
//             Icon(
//               icon,
//               size: 24,
//               color: const AppColors.primary,
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: AppColors.textPrimary,
//                 ),
//               ),
//             ),
//             Radio<String>(
//               value: value,
//               groupValue: groupValue,
//               onChanged: onChanged,
//               activeColor: Colors.orange,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
  
//   Widget _buildProceedButton() {
//     return SizedBox(
//       width: double.infinity,
//       height: 50,
//       child: ElevatedButton(
//         onPressed: () {
//           if (controller.formKey.currentState!.validate()) {
//             if (controller.selectedPaymentMethod.isEmpty) {
//               CustomWidget.showSnackBar("Please select a payment method");
//               return;
//             }
//             // Handle payment logic here
//             _handlePayment();
//           }
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const AppColors.primary,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//           elevation: 0,
//         ),
//         child: const Text(
//           'PROCEED TO PAYMENT',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
  
//   void _handlePayment() {
//     // Find the appropriate UPI app based on selected payment method
//     ApplicationMeta? selectedApp;
    
//     for (ApplicationMeta app in controller.apps) {
//       final appName = app.upiApplication.appName.toLowerCase();
//       if (controller.selectedPaymentMethod == 'googlepay' && appName.contains('pay')) {
//         selectedApp = app;
//         break;
//       } else if (controller.selectedPaymentMethod == 'phonepe' && appName.contains('phonepe')) {
//         selectedApp = app;
//         break;
//       } else if (controller.selectedPaymentMethod == 'paytm' && appName.contains('paytm')) {
//         selectedApp = app;
//         break;
//       }
//     }
    
//     if (selectedApp != null) {
//       controller.startPaymentSession(selectedApp);
//     } else {
//       CustomWidget.showSnackBar("Selected payment app not found");
//     }
//   }
// }