import 'dart:developer';

import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gold/app/core/models/user_model.dart';
import 'package:gold/app/core/widgets/widgets.dart';

import 'package:gold/app/data/game_number/single_digit.dart';

import 'package:gold/app/modules/StarLine/models/bet_model.dart';
import 'package:gold/app/modules/gali-home/controllers/gali_home_controller.dart';
import 'package:gold/app/modules/gali-home/models/betting_history_model.dart';

import 'package:gold/app/modules/gali-home/models/game_model.dart';
import 'package:gold/app/modules/home/views/create_bet_widget.dart';

class GaliSingleDigit extends StatefulWidget {
  final String gameType;
  final GaliGameModel game;
  final UserModel user;
  const GaliSingleDigit({
    Key? key,
    required this.gameType,
    required this.game,
    required this.user,
  }) : super(key: key);

  @override
  State<GaliSingleDigit> createState() => _GaliSingleDigitState();
}

class _GaliSingleDigitState extends State<GaliSingleDigit>
    with SingleTickerProviderStateMixin {
  late GaliHomeController controller;
  // int selectedIndex = 0;
  String selectedINumber = "";

  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController dropdownSearchFieldController =
      TextEditingController();
  List<GaliBettingHistoryModel> bettingList = [];
  final _formKey = GlobalKey<FormState>();
  num remainingBalance = 0;
  int selectedSession = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(GaliHomeController());
    remainingBalance = widget.user.wallet!;
    selectedSession =
        (widget.game.todayResultDeclared! ||
                !widget.game.isCurrentTimeLessThan())
            ? 1
            : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: 80,
            child: Center(
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
                          color: Colors.white,
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
                              // if (selectedSession == 0) {
                              //   // Switching from OPEN to CLOSE
                              //   setState(() {
                              //     selectedSession = 1;
                              //   });
                              // } else {
                              //   // Switching from CLOSE to OPEN

                              setState(() {
                                selectedSession = 0;
                              });

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
                                        : null, // Grey when open is not available
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'OPEN',
                                style: TextStyle(
                                  color: Colors.white, // White text when closed
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
                                        : null, // Grey when open is not available
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'CLOSE',
                                style: TextStyle(
                                  color: Colors.white, // Brown text when open
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
          ),
          const SizedBox(height: 10),
          _customeDropDownSearch(generateSingleDigits(), "Bid Digit", 1),
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
                return "You don't have enough points, pl add point to move farword";
              }
              return null;
            },
            decoration: const InputDecoration(labelText: "Enter Point"),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (!widget.game.isCurrentTimeLessThan()) {
                  CustomWidget.showSnackBar("Market is already closed");
                  Get.back();
                } else if (remainingBalance <
                    int.parse(_textEditingController.text)) {
                  CustomWidget.showSnackBar(
                    "You don't have enough point to add this game",
                  );
                  return;
                } else {
                  remainingBalance =
                      remainingBalance - int.parse(_textEditingController.text);
                  var bet = GaliBettingHistoryModel(
                    userId: widget.user.id,
                    gameName: widget.game.gameName,
                    betType: widget.gameType,
                    betAmount: int.parse(_textEditingController.text),
                    betTime: selectedSession == 0 ? "Open" : "Close",
                    betNumber: dropdownSearchFieldController.text,
                  );

                  setState(() {
                    _formKey.currentState!.reset();
                    bettingList.add(bet);
                    _textEditingController.text = '';
                    dropdownSearchFieldController.text = '';
                  });
                }
              }
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(MediaQuery.sizeOf(context).width * 0.8, 45),
              backgroundColor: const Color(0xFF6B1C5C),

              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: const Text(
              "ADD BID",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Visibility(
            visible: bettingList.isNotEmpty,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10.0),
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Digit')),
                  DataColumn(label: Text('Amount')),
                  DataColumn(label: Text('Game Type')),
                ],
                rows: List.generate(
                  bettingList.length,
                  (index) => DataRow(
                    cells: [
                      DataCell(Text(bettingList[index].betNumber!.toString())),
                      DataCell(Text(bettingList[index].betAmount.toString())),

                      DataCell(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(bettingList[index].betTime.toString()),
                            IconButton(
                              onPressed: () => removeBetByIndex(index),
                              icon: const Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      // DataCell(Text('3')),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Visibility(
            visible: bettingList.isNotEmpty,
            child: ElevatedButton(
              onPressed: () {
                if (bettingList.isEmpty) {
                  CustomWidget.showSnackBar("Add at least one bet");
                } else {
                  controller.addBett(bettingList);
                  log(bettingList.toString());
            
                  bettingList.clear();
                  setState(() {});
                  // context
                  //     .read<CreateBidBloc>()
                  //     .add(CreateBidRequest(bids: bettingList));
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.sizeOf(context).width * 0.8, 45),
                backgroundColor: const Color(0xFF6B1C5C),
            
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text(
                "SUBMIT",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

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
          labelText: name,
          fillColor: Colors.blueAccent,
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
        return ListTile(style: ListTileStyle.drawer, title: Text(suggestion));
      },
      itemSeparatorBuilder: (context, index) {
        return const Divider();
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
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

  removeBetByIndex(int index) {
    GaliBettingHistoryModel bet = bettingList[index];
    bettingList.removeAt(index);
    setState(() {
      remainingBalance += bet.betAmount!;
    });
  }
}
