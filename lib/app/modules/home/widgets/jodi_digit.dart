// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gold/app/core/models/user_model.dart';
import 'package:gold/app/core/widgets/widgets.dart';
import 'package:gold/app/core/app_color.dart';
import 'package:gold/app/data/game_number/double_digit.dart';
import 'package:gold/app/modules/home/controllers/home_controller.dart';
import 'package:gold/app/modules/home/models/betting_history_model.dart';
import 'package:gold/app/modules/home/models/game_model.dart';
import 'package:gold/app/core/app_color.dart';

class JodiDigit extends StatefulWidget {
  final String gameType;
  final GameModel game;
  final UserModel user;
  const JodiDigit({
    super.key,
    required this.gameType,
    required this.game,
    required this.user,
  });

  @override
  State<JodiDigit> createState() => _JodiDigitState();
}

class _JodiDigitState extends State<JodiDigit> {
  late HomeController controller;
  String selectedINumber = "";

  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController dropdownSearchFieldController =
      TextEditingController();
  List<BettingHistoryModel> bettingList = [];
  final _formKey = GlobalKey<FormState>();
  num remainingBalance = 0;

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
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                _customeDropDownSearch(generateDoubleDigits(), "Jodi Digit"),

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
                            betNumber: getTwoDigitsList(
                              int.parse(dropdownSearchFieldController.text),
                            ),
                          );

                          _formKey.currentState!.reset();
                          bettingList.add(bet);

                          setState(() {});
                          _textEditingController.text = '';
                          dropdownSearchFieldController.text = '';
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
                                bettingList[index].betNumber!.join(""),
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

  // Custom Dropdown Search
  _customeDropDownSearch(List<String> options, String name) {
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
          hintText: "BID DIGITS",
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          fillColor: Colors.grey.shade100,
          filled: true,
          // prefixIcon: Icon(
          //   Icons.numbers,
          //   color: AppColors.secondary,
          // ),
          suffixIcon: Icon(
            Icons.arrow_drop_down_circle_outlined,
            color: AppColors.accent,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 20,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary, width: 1.5),
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
        maxLength: 2,
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

  // Convert a two-digit number to a list of two single digits
  List<String> getTwoDigitsList(int twoDigitNumber) {
    // Ensure the number is two digits
    if (twoDigitNumber < 10 || twoDigitNumber > 99) {
      return ['0', twoDigitNumber.toString()];
    }

    // Extract the tens and units digits
    int tensDigit = twoDigitNumber ~/ 10;
    int unitsDigit = twoDigitNumber % 10;

    // Return the list of two digits
    return [tensDigit.toString(), unitsDigit.toString()];
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
