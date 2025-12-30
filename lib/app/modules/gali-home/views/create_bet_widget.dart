// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gold/app/core/app_color.dart';
import 'package:gold/app/core/models/user_model.dart';

import 'package:gold/app/modules/StarLine/views/single_digit_and_pana.dart';
import 'package:gold/app/modules/gali-home/models/game_model.dart';
import 'package:gold/app/modules/gali-home/widgets/jodi_digit_widget.dart';
import 'package:gold/app/modules/gali-home/widgets/single_digit_widget.dart';



class GaliCreateBetWidget extends StatefulWidget {
  final GaliGameModel game;
  final String gameType;
  final UserModel user;
  const GaliCreateBetWidget(
      {super.key,
      required this.game,
      required this.gameType,
      required this.user});

  @override
  State<GaliCreateBetWidget> createState() => _CreateBetWidgetState();
}

class _CreateBetWidgetState extends State<GaliCreateBetWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('${widget.gameType} - ${widget.game.gameName}'),
        backgroundColor: AppColors.primary,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
               Container(
            margin: const EdgeInsets.only(bottom: 20),
            height: 130,
            width: 250,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
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
                    color: AppColors.textOnPrimary,
                    letterSpacing: 0.5,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(
                    height: 1,
                    color: AppColors.textOnPrimary,
                    thickness: 2.5,
                  ),
                ),
                const Text(
                  "Balance",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textOnPrimary,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
                  const SizedBox(
                    height: 25,
                  ),
                  renderWidget()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  renderWidget() {

     bool singleDigitCondition = (widget.gameType == "Single Digit");
    bool doubleDigitCondition = (widget.gameType == 'Jodi Digit');
   

   return  Visibility(
      replacement: Visibility(
          visible: doubleDigitCondition,
          child: GaliJodiDigit(
              gameType: widget.gameType, game: widget.game, user: widget.user)),
      visible: singleDigitCondition,
      child: GaliSingleDigit(
          gameType: widget.gameType, game: widget.game, user: widget.user),
    );
  }
}
