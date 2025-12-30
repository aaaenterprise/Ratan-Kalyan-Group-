import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:gold/app/modules/home/controllers/home_controller.dart';

class BasicDemo extends GetView<HomeController> {
  const BasicDemo({super.key});

  @override
  Widget build(BuildContext context) {

      return GetBuilder(
        init: controller,
        builder: (contex) {
          return Visibility(
            replacement: const SizedBox.shrink(),
            visible: controller.imageList.isNotEmpty,
            child: ImageSlideshow(
              /// Width of the [ImageSlideshow].
              width: double.infinity,

              /// Height of the [ImageSlideshow].
              height: MediaQuery.sizeOf(context).height * 0.22,

              /// The page to show when first creating the [ImageSlideshow].
              initialPage: 0,

              /// The color to paint the indicator.
              indicatorColor: Colors.blue,

              /// The color to paint behind th indicator.
              indicatorBackgroundColor: Colors.grey,

              /// Auto scroll interval.
              /// Do not auto scroll with null or 0.
              autoPlayInterval: 3000,

              /// Loops back to first slide.
              isLoop: true,

              /// The widgets to display in the [ImageSlideshow].
              /// Add the sample image file into the images folder
              children: controller.imageList
                  // .map((item) =>Image.asset(item.file.toString().split(",")[1]))
                  .map(
                    (item) => Image.memory(
                      base64Decode(
                        item.file.toString().split(",")[1],
                      ),
                      fit: BoxFit.fitWidth,
                    ),
                  )
                  .toList(),
            ),
          );
        }
      );
    }


}
