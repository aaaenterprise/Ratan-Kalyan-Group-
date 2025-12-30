// ignore_for_file: public_member_api_docs, sort_constructors_first

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
import 'package:gold/app/core/app_color.dart';

const sangamArray = ["Half Sangam", "Full Sangam"];

class SangamWidget extends StatefulWidget {
  final String gameType;
  final GameModel game;
  final UserModel user;
  const SangamWidget({
    super.key,
    required this.gameType,
    required this.game,
    required this.user,
  });

  @override
  State<SangamWidget> createState() => _SangamWidgetState();
}

class _SangamWidgetState extends State<SangamWidget> {
  late HomeController controller;
  String selectedINumber = "";

  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController dropdownSearchFieldController1 =
      TextEditingController();
  final TextEditingController dropdownSearchFieldController2 =
      TextEditingController();
  List<BettingHistoryModel> bettingList = [];
  final _formKey = GlobalKey<FormState>();
  num remainingBalance = 0;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = Get.put(HomeController());
    remainingBalance = widget.user.wallet ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Game Type Selection for Half Sangam
          if (widget.gameType == sangamArray[0])
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(20),
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
                  Text(
                    "SELECT SANGAM TYPE",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButtonFormField<int>(
                      value: selectedIndex,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        border: InputBorder.none,
                        hintText: "Choose sangam type",
                      ),
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.primary,
                      ),
                      items: const [
                        DropdownMenuItem<int>(
                          value: 0,
                          child: Text(
                            "Open Ank - Close Patti",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        DropdownMenuItem<int>(
                          value: 1,
                          child: Text(
                            "Open Patti - Close Ank",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                      onChanged: (int? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedIndex = newValue;
                            dropdownSearchFieldController1.text = '';
                            dropdownSearchFieldController2.text = '';
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a sangam type';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),

          // Number Selection and Bet Amount
          Container(
            padding: const EdgeInsets.all(20),
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
                // Dropdowns for number selection
                _buildCustomDropDownSearches(),

                const SizedBox(height: 25),

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
                      fontSize: 14,
                    ),
                    fillColor: Colors.grey.shade100,
                    filled: true,

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
                        } else if (remainingBalance <
                            int.parse(_textEditingController.text)) {
                          CustomWidget.showSnackBar(
                            "You don't have enough point to add this game",
                          );
                        } else {
                          remainingBalance =
                              remainingBalance -
                              int.parse(_textEditingController.text);
                          var bet = BettingHistoryModel(
                            userId: widget.user.id,
                            gameName: widget.game.gameName,
                            betType: widget.gameType,
                            betAmount: int.parse(_textEditingController.text),
                            betTime: "",
                            betNumber: [
                              dropdownSearchFieldController1.text,
                              dropdownSearchFieldController2.text,
                            ],
                          );

                          _formKey.currentState!.reset();
                          bettingList.add(bet);

                          setState(() {});
                          _textEditingController.text = '';
                          dropdownSearchFieldController1.text = '';
                          dropdownSearchFieldController2.text = '';
                        }
                      }
                    },
                    width: MediaQuery.sizeOf(context).width * 0.8,
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
                                bettingList[index].betNumber!.join(" - "),
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
                              flex: 1,
                              child: Center(
                                child: IconButton(
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

  // Helper method to build Sangam type selection buttons
  Widget _buildSangamTypeButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: BoxDecoration(
          gradient:
              isSelected
                  ? LinearGradient(
                    colors: [
                      AppColors.secondary,
                      AppColors.accent,
                    ],
                  )
                  : null,
          color: isSelected ? null : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border:
              isSelected
                  ? null
                  : Border.all(color: Colors.grey.shade400, width: 1.5),
          boxShadow:
              isSelected
                  ? [
                    BoxShadow(
                      color: AppColors.secondary.withOpacity(0.3),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ]
                  : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : AppColors.primary,
              letterSpacing: 0.3,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  // Build both custom dropdown searches
  Widget _buildCustomDropDownSearches() {
    // Determine the types based on game type and selected index
    String name1 = '';
    String name2 = '';
    List<String> option1 = [];
    List<String> option2 = [];

    if (widget.gameType == sangamArray[1]) {
      name1 = "Open Patti";
      name2 = "Close Patti";
      option1 = singlePanaNumbers + doublePanaNumbers + triplePanaNumbers;
      option2 = singlePanaNumbers + doublePanaNumbers + triplePanaNumbers;
    } else if (selectedIndex == 0) {
      name1 = 'Open Ank';
      name2 = 'Close Patti';
      option1 = generateSingleDigits();
      option2 = singlePanaNumbers + doublePanaNumbers + triplePanaNumbers;
    } else {
      name1 = "Open Patti";
      name2 = "Close Ank";
      option1 = singlePanaNumbers + doublePanaNumbers + triplePanaNumbers;
      option2 = generateSingleDigits();
    }

    return Column(
      children: [
        // First Dropdown
        _buildCustomDropDown(
          controller: dropdownSearchFieldController1,
          options: option1,
          label: name1,
          hint: "Select $name1",
          maxLength: name1.contains('Ank') ? 1 : 3,
        ),

        const SizedBox(height: 20),

        // Second Dropdown
        _buildCustomDropDown(
          controller: dropdownSearchFieldController2,
          options: option2,
          label: name2,
          hint: "Select $name2",
          maxLength: name2.contains('Ank') ? 1 : 3,
        ),
      ],
    );
  }

  // Build individual custom dropdown
  Widget _buildCustomDropDown({
    required TextEditingController controller,
    required List<String> options,
    required String label,
    required String hint,
    required int maxLength,
  }) {
    SuggestionsBoxController suggestionBoxController =
        SuggestionsBoxController();

    List<String> getSuggestions(String query) {
      List<String> matches = <String>[];
      matches.addAll(options);
      matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
      return matches;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.primary.withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 8),
        DropDownSearchFormField(
          textFieldConfiguration: TextFieldConfiguration(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              fillColor: Colors.grey.shade100,
              filled: true,
              // prefixIcon: Icon(
              //   maxLength == 1 ? Icons.filter_1 : Icons.filter_3,
              //   color: AppColors.secondary,
              // ),
              // suffixIcon: Icon(
              //   Icons.arrow_drop_down_circle_outlined,
              //   color: AppColors.accent,
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
              counter: const SizedBox.shrink(),
            ),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            controller: controller,
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
            controller.text = suggestion;
          },
          suggestionsBoxController: suggestionBoxController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please select $label';
            }
            return null;
          },
          displayAllSuggestionWhenTap: true,
        ),
      ],
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
}
