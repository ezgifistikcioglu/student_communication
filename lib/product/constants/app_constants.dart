import 'package:flutter/material.dart';

class ApplicationConstants {
  static const String unknownText = 'Unknown';

  // Padding
  static const EdgeInsets normalPadding = EdgeInsets.all(8);
  static const EdgeInsets normal2xPadding = EdgeInsets.all(18);
  static const EdgeInsets symmetricPadding =
      EdgeInsets.symmetric(horizontal: 16, vertical: 8);
  static const EdgeInsets onlyPadding = EdgeInsets.only(top: 8, bottom: 8);
}

// MediaQuery
double getMaxWidth(BuildContext context) =>
    MediaQuery.of(context).size.width * 0.7;

double getMinWidth(BuildContext context) =>
    MediaQuery.of(context).size.width * 0.06;

double getMaxHeight(BuildContext context) =>
    MediaQuery.of(context).size.width * 0.9;

double getMinHeight(BuildContext context) =>
    MediaQuery.of(context).size.width * 0.08;

double getWidth(BuildContext context) => MediaQuery.of(context).size.width;
double getHeight(BuildContext context) => MediaQuery.of(context).size.height;

// SizedBox
SizedBox get sizedBoxFive => const SizedBox(height: 5);
SizedBox get sizedBoxTen => const SizedBox(height: 10);
SizedBox get sizedBoxFifteen => const SizedBox(height: 15);

// Color
Color get midPurple => const Color(0xFF985EA2);
Color get lightPurple => const Color(0xFFF7CFFE);
Color get normalPurple => const Color(0xFF9C27B0);

BoxDecoration ellipticalBoxDecoration() {
  return BoxDecoration(
    color: normalPurple,
    borderRadius: const BorderRadius.all(
      Radius.elliptical(100, 16),
    ),
  );
}

Container textLengthContainer(Widget? child) {
  return Container(
    margin: const EdgeInsets.all(0.05),
    decoration: ellipticalBoxDecoration(),
    padding: ApplicationConstants.onlyPadding,
    child: Center(
      child: child,
    ),
  );
}
