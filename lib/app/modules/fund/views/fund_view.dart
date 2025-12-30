import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold/app/routes/app_pages.dart';

import '../controllers/fund_controller.dart';

class FundView extends GetView<FundController> {
  const FundView({super.key});

  // Navigate to next page

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3ebfa),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6B1C5C),
        title: const Text("My Wallet"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          // Wallet Balance
          Center(
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Column(
                children: [
                  const Icon(Icons.account_balance_wallet, size: 30),
                  const SizedBox(height: 8),
                  Text(
                    controller.userController.userModel?.wallet.toString() ??
                        "0",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),

          // Buttons
          WalletButton(
            title: "Add Funds",
            onTap: () => Get.toNamed(Routes.ADD_POINT),
          ),
          WalletButton(
            title: "Withdraw Funds",
            // onTap: () => navigate(context, "Withdraw Funds"),
            onTap: () => Get.toNamed(Routes.WITHDRAW_POINT),
          ),
          WalletButton(
            title: "Bid History",
            // onTap: () => navigate(context, "Bid History"),
            onTap: () => Get.toNamed(Routes.BID_HISTORY),
          ),
          WalletButton(
            title: "Winning History",
            // onTap: () => navigate(context, "Winning History"),
            onTap: () => Get.toNamed(Routes.WINNING_HISTORY),
          ),
          WalletButton(
            title: "Transaction History",
            // onTap: () => navigate(context, "Transaction History"),
            onTap: () => Get.toNamed(Routes.TRANSACTION),
          ),
        ],
      ),
    );
  }
}

// Reusable Wallet Button
class WalletButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const WalletButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Colors.black),
          ),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 16)),
            const Icon(Icons.arrow_forward_ios, color: Colors.purple),
          ],
        ),
      ),
    );
  }
}

// Next Page Template
class NextPage extends StatelessWidget {
  final String title;
  const NextPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6B1C5C),
        title: Text(title),
      ),
      body: Center(
        child: Text(
          "Welcome to $title page",
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
