

import 'dart:developer';

import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gold/app/core/models/user_model.dart';
import 'package:gold/app/core/widgets/widgets.dart';
import 'package:gold/app/data/constant/color_constant.dart';
import 'package:gold/app/data/game_number/double_pana.dart';
import 'package:gold/app/data/game_number/single_digit.dart';
import 'package:gold/app/data/game_number/single_pana.dart';
import 'package:gold/app/data/game_number/triple_pana.dart';
import 'package:gold/app/modules/StarLine/controllers/star_line_controller.dart';
import 'package:gold/app/modules/StarLine/models/bet_model.dart';
import 'package:gold/app/modules/StarLine/models/star_line_game_model.dart';
import 'package:gold/app/modules/home/views/create_bet_widget.dart';

class StarLineSingleDigitAndPana extends StatefulWidget {
  final String gameType;
  final StarLineGameModel game;
  final UserModel user;
  const StarLineSingleDigitAndPana({
    super.key,
    required this.gameType,
    required this.game,
    required this.user,
  });

  @override
  State<StarLineSingleDigitAndPana> createState() => _SingleDigitAndPanaState();
}

class _SingleDigitAndPanaState extends State<StarLineSingleDigitAndPana>
    with SingleTickerProviderStateMixin {
  late StarLineController controller;
  String selectedINumber = "";

  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController dropdownSearchFieldController =
      TextEditingController();
  List<StarLineBetModel> bettingList = [];
  final _formKey = GlobalKey<FormState>();
  num remainingBalance = 0;
  int selectedSession = 0;
  
  @override
  void initState() {
    super.initState();
    controller = Get.put(StarLineController());
    remainingBalance = widget.user.wallet!;
   
  }

  @override
  Widget build(BuildContext context) {
  
    
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Session Selection (Open/Close)
          // Container(
          //   margin: const EdgeInsets.only(bottom: 20),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(15),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.black.withOpacity(0.1),
          //         blurRadius: 8,
          //         offset: const Offset(0, 3),
          //       ),
          //     ],
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.only(left: 12, top: 8, bottom: 12),
          //           child: Text(
          //             "SELECT SESSION",
          //             style: TextStyle(
          //               fontSize: 14,
          //               fontWeight: FontWeight.bold,
          //               color: ColorConstant.primaryColor,
          //               letterSpacing: 0.5,
          //             ),
          //           ),
          //         ),
          //         Row(
          //           children: [
          //             Expanded(
          //               child: _buildSessionButton(
          //                 label: "OPEN",
          //                 value: 0,
          //                 isSelected: selectedSession == 0,
          //                 isEnabled: isOpenAvailable,
          //                 onTap: () {
          //                   if (isOpenAvailable) {
          //                     setState(() {
          //                       selectedSession = 0;
          //                     });
          //                   } else {
          //                     CustomWidget.showSnackBar("Open session is closed");
          //                   }
          //                 },
          //               ),
          //             ),
          //             const SizedBox(width: 15),
          //             Expanded(
          //               child: _buildSessionButton(
          //                 label: "CLOSE",
          //                 value: 1,
          //                 isSelected: selectedSession == 1,
          //                 isEnabled: true,
          //                 onTap: () {
          //                   setState(() {
          //                     selectedSession = 1;
          //                   });
          //                 },
          //               ),
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          
          // Game Inputs Container
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Number Selection Dropdown
                Text(
                  "SELECT NUMBER",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.primaryColor,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 10),
                widget.gameType == singleDigitAndPanaArray[0]
                  ? _customeDropDownSearch(
                      generateSingleDigits(), singleDigitAndPanaArray[0], 1)
                  : widget.gameType == singleDigitAndPanaArray[1]
                      ? _customeDropDownSearch(
                          singlePanaNumbers, singleDigitAndPanaArray[1], 3)
                      : widget.gameType == singleDigitAndPanaArray[2]
                          ? _customeDropDownSearch(
                              doublePanaNumbers, singleDigitAndPanaArray[2], 3)
                          : _customeDropDownSearch(
                              triplePanaNumbers, singleDigitAndPanaArray[3], 3),
                
                const SizedBox(height: 25),
                
                // Amount Input
                Text(
                  "ENTER POINTS",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.primaryColor,
                    letterSpacing: 0.5,
                  ),
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
                    color: ColorConstant.textDark,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter your bid amount",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 14,
                    ),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    prefixIcon: Icon(
                      Icons.account_balance_wallet_outlined,
                      color: ColorConstant.goldColor,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorConstant.goldColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorConstant.errorColor,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorConstant.errorColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                
                // Wallet Balance Display
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.account_balance_wallet,
                        size: 16,
                        color: ColorConstant.goldColor,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Available Balance: ",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        "₹${remainingBalance.toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: ColorConstant.goldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 25),
                
                // Add Button
                Center(
                  child: _buildGradientButton(
                    label: "ADD BET",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (!widget.game.isCurrentTimeLessThan()) {
                          CustomWidget.showSnackBar("Market is already closed");
                          Get.back();
                        } else if (remainingBalance <
                            int.parse(_textEditingController.text)) {
                          CustomWidget.showSnackBar(
                              "You don't have enough point to add this game");
                          return;
                        } else {
                          remainingBalance = remainingBalance -
                              int.parse(_textEditingController.text);
                          var bet = StarLineBetModel(
                              userId: widget.user.id,
                              gameName: widget.game.gameName,
                              betType: widget.gameType,
                              betAmount: int.parse(_textEditingController.text),
                             
                              betNumber: dropdownSearchFieldController.text);

                          setState(() {
                            _formKey.currentState!.reset();
                            bettingList.add(bet);
                            _textEditingController.text = '';
                            dropdownSearchFieldController.text = '';
                          });
                        }
                      }
                    },
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    gradient: LinearGradient(
                      colors: [
                        ColorConstant.accentColor,
                        ColorConstant.goldColor,
                      ],
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "YOUR BETS",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ColorConstant.primaryColor,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: ColorConstant.goldColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: ColorConstant.goldColor.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            "${bettingList.length} Bets",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: ColorConstant.goldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Table Headers
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: ColorConstant.primaryColor.withOpacity(0.05),
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "DIGIT",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "AMOUNT",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "ACTION",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Bets List Items
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: bettingList.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      color: Colors.grey.shade200,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: ColorConstant.goldColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: ColorConstant.goldColor.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  bettingList[index].betNumber!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstant.primaryColor,
                                  ),
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  
                                  IconButton(
                                    onPressed: () => removeBetByIndex(index),
                                    icon: Icon(
                                      Icons.delete_outline,
                                      color: Colors.red.shade600,
                                      size: 20,
                                    ),
                                    style: IconButton.styleFrom(
                                      backgroundColor: Colors.red.withOpacity(0.1),
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
                  
                  // Total Amount
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: ColorConstant.primaryColor.withOpacity(0.03),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "TOTAL AMOUNT",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: ColorConstant.primaryColor,
                          ),
                        ),
                        Text(
                          "₹${bettingList.fold(0, (sum, bet) => sum + (bet.betAmount ?? 0))}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ColorConstant.goldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          // Submit Button
          if (bettingList.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _buildGradientButton(
                label: "SUBMIT ALL BETS",
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
                gradient: LinearGradient(
                  colors: [
                    ColorConstant.primaryColor,
                    ColorConstant.primaryColor.withOpacity(0.8),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Custom Dropdown Search
  _customeDropDownSearch(List<String> options, String name, int maxLength) {
    SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();
    
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
          hintText: "Select $name",
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 14,
          ),
          fillColor: Colors.grey.shade100,
          filled: true,
          prefixIcon: Icon(
            Icons.numbers,
            color: ColorConstant.goldColor,
          ),
          suffixIcon: Icon(
            Icons.arrow_drop_down_circle_outlined,
            color: ColorConstant.accentColor,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorConstant.goldColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade300,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorConstant.errorColor,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorConstant.errorColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          counter: const SizedBox.shrink(),
        ),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
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
              bottom: BorderSide(
                color: Colors.grey.shade200,
                width: 1,
              ),
            ),
          ),
          child: Text(
            suggestion,
            style: TextStyle(
              fontSize: 16,
              color: ColorConstant.textDark,
            ),
          ),
        );
      },
      itemSeparatorBuilder: (context, index) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
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
    StarLineBetModel bet = bettingList[index];
    bettingList.removeAt(index);
    setState(() {
      remainingBalance += bet.betAmount!;
    });
  }
  
  // Helper method to build session selection buttons
  Widget _buildSessionButton({
    required String label,
    required int value,
    required bool isSelected,
    required bool isEnabled,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          gradient: isSelected && isEnabled
            ? LinearGradient(
                colors: [
                  value == 0 ? Colors.green.shade600 : Colors.blue.shade600,
                  value == 0 ? Colors.green.shade800 : Colors.blue.shade800,
                ],
              )
            : null,
          color: isSelected || !isEnabled
            ? isEnabled
                ? null
                : Colors.grey.shade300
            : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
            ? null
            : Border.all(
                color: isEnabled
                  ? Colors.grey.shade400
                  : Colors.grey.shade300,
                width: 1.5,
              ),
          boxShadow: isSelected && isEnabled
            ? [
                BoxShadow(
                  color: (value == 0 ? Colors.green : Colors.blue).withOpacity(0.3),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              value == 0 
                ? Icons.wb_sunny_outlined
                : Icons.nightlight_outlined,
              size: 18,
              color: isSelected && isEnabled
                ? Colors.white
                : isEnabled
                  ? value == 0
                    ? Colors.green.shade700
                    : Colors.blue.shade700
                  : Colors.grey.shade600,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isSelected && isEnabled
                  ? Colors.white
                  : isEnabled
                    ? value == 0
                      ? Colors.green.shade700
                      : Colors.blue.shade700
                    : Colors.grey.shade600,
              ),
            ),
            if (!isEnabled)
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Icon(
                  Icons.lock,
                  size: 14,
                  color: Colors.grey.shade600,
                ),
              ),
          ],
        ),
      ),
    );
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
            color: ColorConstant.goldColor.withOpacity(0.3),
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
            color: Colors.white,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}