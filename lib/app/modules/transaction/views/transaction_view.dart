import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold/app/core/app_color.dart';
import 'package:gold/app/core/app_color.dart';
import 'package:intl/intl.dart';

import '../controllers/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          "Transactions",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              // Filter action can be added here if needed
            },
            icon: const Icon(
              Icons.filter_list,
              color: Colors.white,
              size: 24,
            ),
            tooltip: "Filter transactions",
          ),
        ],
      ),
      body: GetBuilder(
        init: controller,
        builder: (context) {
          if (controller.transections.isEmpty) {
            return _buildEmptyState();
          }

          return Column(
            children: [
              // Table Header
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  border: Border(
                    bottom: BorderSide(color: AppColors.border!, width: 1),
                  ),
                ),
                child: const Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Type",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Amount",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        "Date",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),

              // Transaction List
              Expanded(
                child: ListView.builder(
                  itemCount: controller.transections.length,
                  itemBuilder: (BuildContext context, int index) {
                    var transaction = controller.transections[index];
                    bool isCredit = transaction.type == 'credit';

                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      decoration: BoxDecoration(
                        color: index % 2 == 0 ? Colors.white : AppColors.surface,
                        border: Border(
                          bottom: BorderSide(color: AppColors.border!, width: 0.5),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // Transaction Type
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Icon(
                                      isCredit
                                          ? Icons.arrow_downward
                                          : Icons.arrow_upward,
                                      size: 16,
                                      color: isCredit
                                          ? AppColors.success
                                          : AppColors.error,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      isCredit ? "CREDIT" : "DEBIT",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: isCredit
                                            ? AppColors.success
                                            : AppColors.error,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Amount
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "₹${transaction.amount ?? 0}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: isCredit
                                        ? AppColors.successDark
                                        : AppColors.errorDark,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),

                              // Date
                              Expanded(
                                flex: 3,
                                child: Text(
                                  _formatDateForTable(transaction),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),

                          // Description (if available)
                          if (transaction.description != null && 
                              transaction.description!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.description_outlined,
                                    size: 14,
                                    color: AppColors.textSecondary,
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      transaction.description ?? "",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textSecondary,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _formatDateForTable(dynamic transaction) {
    try {
      if (transaction.timestamp != null) {
        final timestamp = transaction.timestamp.toString().split(".").first;
        final DateTime dateTime = DateTime.parse(timestamp);
        return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
      }
    } catch (e) {
      return transaction.timestamp?.toString().split(".").first ?? "N/A";
    }
    return "N/A";
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            size: 80,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 20),
          Text(
            "No Transactions Found",
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Your transaction history will appear here",
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}