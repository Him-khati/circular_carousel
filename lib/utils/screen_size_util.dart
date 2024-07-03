import 'package:flutter/material.dart';

class ScreenSizeUtil {
  static bool isAtLeastLargeScreen(BuildContext context) {
    return isLargeScreen(context) && !isMediumScreen(context);
  }

  static bool isLargeScreen(BuildContext context) {
    return getScreenSize(context).width > 768;
  }

  static bool isMediumScreen(BuildContext context) {
    final screenSize = getScreenSize(context);
    return screenSize.width >= 768 && screenSize.width < 1200;
  }

  static bool isSmallScreen(BuildContext context) {
    return getScreenSize(context).width < 768;
  }

  static Size getScreenSize(BuildContext context) =>
      MediaQuery.of(context).size;

  static double getScreenWidth(BuildContext context) {
    return getScreenSize(context).width;
  }

  static double getScreenHeight(BuildContext context) {
    return getScreenSize(context).height;
  }
}

extension ScreenSizeExtensions on BuildContext {
  // Is a large screen like Laptop/Desktop screen
  bool get isLargeScreen => ScreenSizeUtil.isLargeScreen(this);

  // Is a large screen like Tablet screen
  bool get isMediumScreen => ScreenSizeUtil.isMediumScreen(this);

  // Is a large screen like Phone screen
  bool get isSmallScreen => ScreenSizeUtil.isSmallScreen(this);
}
