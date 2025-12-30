import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/create_bet_controller.dart';

class CreateBetView extends GetView<CreateBetController> {
  const CreateBetView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CreateBetView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CreateBetView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
