import 'dart:developer';

import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gold/app/core/models/user_model.dart';
import 'package:gold/app/core/widgets/widgets.dart';
import 'package:gold/app/core/app_color.dart';
import 'package:gold/app/data/game_number/double_pana.dart';
import 'package:gold/app/data/game_number/single_digit.dart';
import 'package:gold/app/data/game_number/single_pana.dart';
import 'package:gold/app/data/game_number/triple_pana.dart';
import 'package:gold/app/modules/home/controllers/home_controller.dart';
import 'package:gold/app/modules/home/models/betting_history_model.dart';
import 'package:gold/app/modules/home/models/game_model.dart';
import 'package:gold/app/modules/home/views/create_bet_widget.dart';
import 'package:gold/app/core/app_color.dart';

List<String> testInputs = [
  "1234", // 4 digits
  "12345", // 5 digits
  "123456", // 6 digits
  "1234567", // 7 digits
  "12345678", // 8 digits
  "123456789", // 9 digits
  "1234567890", // 10 digits
];

class Motors extends StatefulWidget {
  final String gameType;
  final GameModel game;
  final UserModel user;
  const Motors({
    super.key,
    required this.gameType,
    required this.game,
    required this.user,
  });

  @override
  State<Motors> createState() => _MotorsState();
}

class _MotorsState extends State<Motors> with SingleTickerProviderStateMixin {
  late HomeController controller;
  String selectedINumber = "";

  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController dropdownSearchFieldController =
      TextEditingController();
  List<BettingHistoryModel> bettingList = [];
  final _formKey = GlobalKey<FormState>();
  num remainingBalance = 0;
  int selectedSession = 0;

  @override
  void initState() {
    super.initState();
    controller = Get.put(HomeController());
    remainingBalance = widget.user.wallet!;
    selectedSession =
        (widget.game.todayResultDeclared! ||
                !widget.game.isCurrentTimeLessThan(false))
            ? 1
            : 0;
  }

  /// Alternative comprehensive approach that generates all combinations systematically
  /// This ensures we don't miss any valid double pana patterns
  List<String> getSinglePanaNumbersComprehensive(String inputNumber) {
    String numStr = inputNumber.toString();

    // Validate input
    if (numStr.length < 4 || numStr.length > 10) {
      throw ArgumentError('Input number must have 4-10 digits');
    }

    Set<String> uniqueDigits = numStr.split('').toSet();
    if (uniqueDigits.length != numStr.length) {
      throw ArgumentError('Input number cannot have duplicate digits');
    }

    List<String> digits = numStr.split('');
    Set<String> validPanaNumbers = <String>{};
    Set<String> panaSet = singlePanaNumbers.toSet();

    // Generate all possible single pana patterns (ABC type):
    // All three digits must be different

    for (int i = 0; i < digits.length; i++) {
      for (int j = 0; j < digits.length; j++) {
        for (int k = 0; k < digits.length; k++) {
          // Ensure all three digits are different
          if (i != j && j != k && i != k) {
            String pattern = digits[i] + digits[j] + digits[k];
            if (panaSet.contains(pattern)) {
              validPanaNumbers.add(pattern);
            }
          }
        }
      }
    }

    List<String> result = validPanaNumbers.toList();
    result.sort();
    return result;
  }

  List<String> getDoublePanaNumbersComprehensive(String inputNumber) {
    String numStr = inputNumber.toString();

    // Validate input
    if (numStr.length < 4 || numStr.length > 10) {
      throw ArgumentError('Input number must have 4-10 digits');
    }

    Set<String> uniqueDigits = numStr.split('').toSet();
    if (uniqueDigits.length != numStr.length) {
      throw ArgumentError('Input number cannot have duplicate digits');
    }

    List<String> digits = numStr.split('');
    Set<String> validPanaNumbers = <String>{};
    Set<String> panaSet = doublePanaNumbers.toSet();

    // Generate all possible double pana patterns:
    // 1. AAB type: Two same digits + one different digit
    // 2. AAA type: All three digits same

    for (String digit in digits) {
      // Pattern AAA: All three digits same
      String triplePattern = digit + digit + digit;
      if (panaSet.contains(triplePattern)) {
        validPanaNumbers.add(triplePattern);
      }

      // Pattern AAB, ABA, BAA: Two same + one different
      for (String otherDigit in digits) {
        if (digit != otherDigit) {
          // AAB pattern
          String pattern1 = digit + digit + otherDigit;
          if (panaSet.contains(pattern1)) {
            validPanaNumbers.add(pattern1);
          }

          // ABA pattern
          String pattern2 = digit + otherDigit + digit;
          if (panaSet.contains(pattern2)) {
            validPanaNumbers.add(pattern2);
          }

          // BAA pattern
          String pattern3 = otherDigit + digit + digit;
          if (panaSet.contains(pattern3)) {
            validPanaNumbers.add(pattern3);
          }
        }
      }
    }

    List<String> result = validPanaNumbers.toList();
    result.sort();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final bool isOpenAvailable =
        !widget.game.todayResultDeclared! &&
        widget.game.isCurrentTimeLessThan(false);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            height: 130,
            width: 250,
            decoration: BoxDecoration(
              color: const AppColors.primary,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowMedium,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "₹ ${widget.user.wallet}  ",
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: AppColors.cardBackground,
                    letterSpacing: 0.5,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(
                    height: 1,
                    color: AppColors.cardBackground,
                    thickness: 2.5,
                  ),
                ),
                const Text(
                  "Balance",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.cardBackground,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          // Session Selection (Open/Close)
          Center(
            child: Container(
              height: 70,
              width: 350,
              decoration: BoxDecoration(
                color: const Color(0xFF8B4513), // Brown color
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Date section
                  const Padding(
                    padding: EdgeInsets.only(left: 16, right: 8),
                    child: Text(
                      '10, Sep 2025',
                      style: TextStyle(
                        color: AppColors.cardBackground,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: // Close/Toggle button
                        Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (isOpenAvailable) {
                              setState(() {
                                selectedSession = 0;
                              });
                            } else {
                              CustomWidget.showSnackBar(
                                "Open session is closed",
                              );
                            }
                            // }
                          },
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  selectedSession == 0
                                      ? const Color(
                                        0xFFD4AF37,
                                      ) // Gold color when open
                                      : (isOpenAvailable
                                          ? null // Gold color when can switch to open
                                          : Colors
                                              .grey[600]), // Grey when open is not available
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'OPEN',
                              style: TextStyle(
                                color: AppColors.cardBackground, // White text when closed
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSession = 1;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  selectedSession == 1
                                      ? const Color(
                                        0xFFD4AF37,
                                      ) // Gold color when open
                                      : (isOpenAvailable
                                          ? null // Gold color when can switch to open
                                          : Colors
                                              .grey[600]), // Grey when open is not available
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'CLOSE',
                              style: TextStyle(
                                color: AppColors.cardBackground, // Brown text when open
                                // White text when closed
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Game Inputs Container
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _customeDropDownSearch(
                  testInputs,
                  singleDigitAndPanaArray[3],
                  3,
                ),

                const SizedBox(height: 10),
                TextFormField(
                  controller: _textEditingController,
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Point required";
                    } else if (int.parse(value) < 10) {
                      return "Minimum point should be 10";
                    } else if (int.parse(value) > widget.user.wallet!) {
                      return "You don't have enough points";
                    }
                    return null;
                  },
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter Amount",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 18,
                    ),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    // prefixIcon: Icon(
                    //   Icons.account_balance_wallet_outlined,
                    //   color: AppColors.secondary,
                    // ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 20,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primary,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primary,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.error,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.error,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Add Button
                Center(
                  child: _buildGradientButton(
                    label: "ADD BID",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (!widget.game.isCurrentTimeLessThan(true)) {
                          CustomWidget.showSnackBar("Market is already closed");
                          Get.back();
                        } else if (selectedSession == 0 &&
                            !widget.game.isCurrentTimeLessThan(false)) {
                          CustomWidget.showSnackBar(
                            "Open Market is already closed",
                          );
                          return;
                        } else if (remainingBalance <
                            int.parse(_textEditingController.text)) {
                          CustomWidget.showSnackBar(
                            "You don't have enough point to add this game",
                          );
                          return;
                        } else {
                          // Improved betting logic with multiple bets creation
                          List<String> numbers =
                              widget.gameType == motorsArray[0]
                                  ? getSinglePanaNumbersComprehensive(
                                    dropdownSearchFieldController.text,
                                  )
                                  : getDoublePanaNumbersComprehensive(
                                    dropdownSearchFieldController.text,
                                  );

                          log(numbers.toString());
                          // Validate sufficient balance before creating bets
                          int totalBetAmount =
                              int.parse(_textEditingController.text) *
                              numbers.length;
                          if (remainingBalance < totalBetAmount) {
                            // Show error message - insufficient balance
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Insufficient balance! Required: $totalBetAmount, Available: $remainingBalance',
                                ),
                                backgroundColor: AppColors.error,
                              ),
                            );
                            return;
                          }

                          // Create multiple betting history models - one for each number
                          List<BettingHistoryModel> newBets = [];
                          int individualBetAmount = int.parse(
                            _textEditingController.text,
                          );
                          String betTimeSession =
                              selectedSession == 0 ? "Open" : "Close";
                          String betType =
                              widget.gameType == motorsArray[0]
                                  ? "Single Pana"
                                  : "Double Pana";
                          for (String number in numbers) {
                            var bet = BettingHistoryModel(
                              userId: widget.user.id,
                              gameName: widget.game.gameName,
                              betType: betType,
                              betAmount: individualBetAmount,
                              betTime: betTimeSession,
                              betNumber: [
                                number,
                              ], // Each bet has only one specific number
                            );
                            newBets.add(bet);
                          }

                          // Update remaining balance
                          remainingBalance = remainingBalance - totalBetAmount;

                          // Update UI state
                          setState(() {
                            _formKey.currentState!.reset();
                            bettingList.addAll(
                              newBets,
                            ); // Add all new bets to the list
                            _textEditingController.text = '';
                            dropdownSearchFieldController.text = '';
                          });

                          // List<String>number=getDoublePanaNumbersComprehensive(
                          //   int.parse(dropdownSearchFieldController.text),
                          // );
                          // var bet = BettingHistoryModel(
                          //   userId: widget.user.id,
                          //   gameName: widget.game.gameName,
                          //   betType: widget.gameType,
                          //   betAmount: int.parse(_textEditingController.text),
                          //   betTime: selectedSession == 0 ? "Open" : "Close",
                          //   betNumber: [dropdownSearchFieldController.text],
                          // );
                          // remainingBalance =
                          //     remainingBalance -
                          //     int.parse(_textEditingController.text)*number.length;
                          // setState(() {
                          //   _formKey.currentState!.reset();
                          //   bettingList.add(bet);
                          //   _textEditingController.text = '';
                          //   dropdownSearchFieldController.text = '';
                          // });
                        }
                      }
                    },
                    width: MediaQuery.sizeOf(context).width * 0.80,
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, AppColors.primary],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Bets List
          if (bettingList.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowMedium,
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bets List Items
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: bettingList.length,
                    separatorBuilder:
                        (context, index) =>
                            Divider(height: 1, color: Colors.grey.shade200),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                bettingList[index].betNumber!.first.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "₹${bettingList[index].betAmount.toString()}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    bettingList[index].betTime.toString(),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      // color:
                                      //     bettingList[index].betTime == "Open"
                                      //         ? AppColors.success
                                      //         : AppColors.info,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => removeBetByIndex(index),
                                    icon: Icon(
                                      Icons.delete_outline,
                                      color: AppColors.error,
                                      size: 20,
                                    ),
                                    style: IconButton.styleFrom(
                                      backgroundColor: AppColors.error.withOpacity(
                                        0.1,
                                      ),
                                      padding: const EdgeInsets.all(8),
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
                ],
              ),
            ),

          // Submit Button
          if (bettingList.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _buildGradientButton(
                label: "SUBMIT",
                onPressed: () {
                  if (bettingList.isEmpty) {
                    CustomWidget.showSnackBar("Add at least one bet");
                  } else {
                    controller.addBett(bettingList);
                    log(bettingList.toString());
                    CustomWidget.showSnackBar("Bets placed successfully!");
                    bettingList.clear();
                    setState(() {});
                  }
                },
                width: double.infinity,
                height: 55,
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primary],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Custom Dropdown Search
  _customeDropDownSearch(List<String> options, String name, int maxLength) {
    SuggestionsBoxController suggestionBoxController =
        SuggestionsBoxController();

    List<String> getSuggestions(String query) {
      List<String> matches = <String>[];
      matches.addAll(options);
      matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
      return matches;
    }

    return DropDownSearchFormField(
      textFieldConfiguration: TextFieldConfiguration(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: "Bid Digit",
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          fillColor: Colors.grey.shade100,
          filled: true,
          // prefixIcon: Icon(Icons.numbers, color: AppColors.secondary),
          suffixIcon: null,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 20,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primary,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.error, width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.error, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          counter: const SizedBox.shrink(),
        ),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        controller: dropdownSearchFieldController,
        maxLength: maxLength,
      ),
      suggestionsCallback: (pattern) {
        return getSuggestions(pattern);
      },
      itemBuilder: (context, String suggestion) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade200, width: 1),
            ),
          ),
          child: Text(
            suggestion,
            style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
          ),
        );
      },
      itemSeparatorBuilder: (context, index) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowMedium,
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: suggestionsBox,
        );
      },
      onSuggestionSelected: (String suggestion) {
        dropdownSearchFieldController.text = suggestion;
      },
      suggestionsBoxController: suggestionBoxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please select $name';
        } else if (!options.contains(value)) {
          return "Select a valid number";
        }
        return null;
      },
      displayAllSuggestionWhenTap: true,
    );
  }

  // Helper method to remove a bet from the list
  removeBetByIndex(int index) {
    BettingHistoryModel bet = bettingList[index];
    bettingList.removeAt(index);
    setState(() {
      remainingBalance += bet.betAmount!;
    });
  }

  // Helper method to build gradient buttons
  Widget _buildGradientButton({
    required String label,
    required VoidCallback onPressed,
    required Gradient gradient,
    double width = double.infinity,
    double height = 50,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.cardBackground,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
