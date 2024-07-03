import 'dart:math';

import 'package:carousel_flutter/colors.dart';
import 'package:flutter/material.dart';

import 'carousel_slide_placement_data.dart';

class CarousalSlideWidget extends StatelessWidget {
  final CarouselSlidePlacementAndData data;

  const CarousalSlideWidget({
    super.key,
    required this.data,
  });

  double get slideLeftOpacity =>
      max(0, data.z) / data.maxZ + min(0, data.x) / data.maxX;

  double get slideMidOpacity =>
      max(0, data.z) / data.maxZ + min(0, data.x) / data.maxX;

  double get slideRightOpacity =>
      max(0, data.z) / data.maxZ + max(0, data.x) / data.maxX;

  double get maxZRequiredForColoredPicture => data.maxZ * 0.80 * -1;

  Color get imageColorFilter {
    final Color finalValue;

    if (data.z > maxZRequiredForColoredPicture) {
      finalValue = Colors.grey;
    } else {
      final opacity = (data.z / data.maxZ).abs();
      finalValue = Colors.grey.withOpacity(1 - opacity);
    }

    // print("Color Filter Value : ")
    return finalValue;
  }

  @override
  Widget build(BuildContext context) {
    final slideLeftOpc = min(slideLeftOpacity.abs(), 0.9);
    final slideMidOpc = min(slideMidOpacity.abs(), 0.6);
    final slideRightOpc = min(slideRightOpacity.abs(), 0.9);

    // print("Ops Left ${data.index} : $slideLeftOpc");
    // print("Ops Mid ${data.index} : $slideMidOpc");
    // print("Ops Right ${data.index} : $slideRightOpc");

    return SizedBox(
      key: Key("image${data.index}"),
      height: 450,
      width: 300,
      child: ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(
            colors: [
              kGrey300.withOpacity(
                slideLeftOpc,
              ),
              kGrey300.withOpacity(
                slideMidOpc,
              ),
              kGrey300.withOpacity(
                slideRightOpc,
              ),
            ],
          ).createShader(bounds);
        },
        blendMode: BlendMode.srcOver,
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(imageColorFilter, BlendMode.saturation),
          child: data.data.image,
        ),
      ),
    );
  }
}
