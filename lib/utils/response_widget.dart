import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget smallScreenWidget;
  final Widget mediumScreenWidget;
  final Widget largeScreenWidget;

  const ResponsiveWidget({
    super.key,
    required this.smallScreenWidget,
    required this.mediumScreenWidget,
    required this.largeScreenWidget,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (canDrawLargeScreenWidget(constraints)) {
        return largeScreenWidget;
      } else if (canDrawMediumScreenWidget(constraints)) {
        return mediumScreenWidget;
      } else {
        return smallScreenWidget;
      }
    });
  }

  bool canDrawLargeScreenWidget(BoxConstraints constraints) {
    return constraints.maxWidth > 1200;
  }

  bool canDrawMediumScreenWidget(BoxConstraints constraints) {
    return constraints.maxWidth < 1200 && constraints.maxWidth > 425;
  }
}
