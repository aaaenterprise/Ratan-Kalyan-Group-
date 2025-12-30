import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gold/app/core/widgets/widgets.dart';
import 'package:gold/app/data/constant/assets_constant.dart';
import 'package:gold/app/routes/app_pages.dart';

import '../controllers/game_option_controller.dart';

class GameOptionView extends GetView<GameOptionController> {
  const GameOptionView({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return GetBuilder(
      init: controller,
      builder: (contex) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              controller.game.gameName ?? "",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: SizedBox(
              height: size.height * 0.88,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            var data = {
                              "game": controller.game,
                              "user": controller.user,
                              "type": "Single Digit"
                            };
                            Get.toNamed(
                                "${Routes.HOME}${Routes.GAME_OPTION}${Routes.CREATE_BET}",
                                arguments: data);

                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => CreateBetWidget(
                            //         user: controller.user,
                            //         game: controller.game,
                            //         gameType: "Single Digit"),
                            //   ),
                            // );
                          },
                          child: Image.asset(
                            AssetsConstant.singleDigit,
                            width: size.width * 0.40,
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            if (!controller.game.todayResultDeclared! &&
                                controller.game.isCurrentTimeLessThan(false)) {
                              var data = {
                                "game": controller.game,
                                "user": controller.user,
                                "type": "Jodi Digit"
                              };
                              Get.toNamed(
                                  "${Routes.HOME}${Routes.GAME_OPTION}${Routes.CREATE_BET}",
                                  arguments: data);
                              // Navigator.push(

                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => CreateBetWidget(
                              //         user: controller.user,
                              //         game: controller.game,
                              //         gameType: "Jodi Digit"),
                              //   ),
                              // );
                            } else {
                              CustomWidget.showSnackBar(
                                  "Game is closed for this type",
                                  bgColor: Colors.white,
                                  fgColor: Colors.black);
                            }
                          },
                          child: Image.asset(
                            AssetsConstant.jodiDigit,
                            width: size.width * 0.4,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            var data = {
                              "game": controller.game,
                              "user": controller.user,
                              "type": "Single Pana"
                            };
                            Get.toNamed(
                                "${Routes.HOME}${Routes.GAME_OPTION}${Routes.CREATE_BET}",
                                arguments: data);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => CreateBetWidget(
                            //         user: controller.user,
                            //         game: controller.game,
                            //         gameType: "Single Pana"),
                            //   ),
                            // );
                          },
                          child: Image.asset(
                            AssetsConstant.singlePana,
                            width: size.width * 0.4,
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            var data = {
                              "game": controller.game,
                              "user": controller.user,
                              "type": "Double Pana"
                            };
                            Get.toNamed(
                                "${Routes.HOME}${Routes.GAME_OPTION}${Routes.CREATE_BET}",
                                arguments: data);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => CreateBetWidget(
                            //         user: controller.user,
                            //         game: controller.game,
                            //         gameType: "Double Pana"),
                            //   ),
                            // );
                          },
                          child: Image.asset(
                            AssetsConstant.doublePana,
                            width: size.width * 0.4,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            var data = {
                              "game": controller.game,
                              "user": controller.user,
                              "type": "Triple Pana"
                            };
                            Get.toNamed(
                                "${Routes.HOME}${Routes.GAME_OPTION}${Routes.CREATE_BET}",
                                arguments: data);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => CreateBetWidget(
                            //         user: controller.user,
                            //         game: controller.game,
                            //         gameType: "Triple Pana"),
                            //   ),
                            // );
                          },
                          child: Image.asset(
                            AssetsConstant.triplePana,
                            width: size.width * 0.4,
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            if (!controller.game.todayResultDeclared! &&
                                controller.game.isCurrentTimeLessThan(false)) {
                              var data = {
                                "game": controller.game,
                                "user": controller.user,
                                "type": "Half Sangam"
                              };
                              Get.toNamed(
                                  "${Routes.HOME}${Routes.GAME_OPTION}${Routes.CREATE_BET}",
                                  arguments: data);
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => CreateBetWidget(
                              //         user: controller.user,
                              //         game: controller.game,
                              //         gameType: "Half Sangam"),
                              //   ),
                              // );
                            } else {
                              CustomWidget.showSnackBar(
                                "Game is closed for this type",
                                bgColor: Colors.white,
                                fgColor: Colors.black,
                              );
                            }
                          },
                          child: Image.asset(
                            AssetsConstant.halfSangam,
                            width: size.width * 0.4,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    MaterialButton(
                      onPressed: () {
                        if (!controller.game.todayResultDeclared! &&
                            controller.game.isCurrentTimeLessThan(false)) {
                          var data = {
                            "game": controller.game,
                            "user": controller.user,
                            "type": "Full Sangam"
                          };
                          Get.toNamed(
                              "${Routes.HOME}${Routes.GAME_OPTION}${Routes.CREATE_BET}",
                              arguments: data);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => CreateBetWidget(
                          //         user: controller.user,
                          //         game: controller.game,
                          //         gameType: "Full Sangam"),
                          //   ),
                          // );
                        } else {
                          CustomWidget.showSnackBar(
                            "Game is closed for this type",
                            bgColor: Colors.white,
                            fgColor: Colors.black,
                          );
                        }
                      },
                      child: Image.asset(
                        AssetsConstant.fullSangam,
                        width: size.width * 0.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
