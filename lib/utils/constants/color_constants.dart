import 'package:flutter/material.dart';

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}

class ColorConstants {
  static Color primaryAppColor = Colors.purple;
  static Color primaryAppColor20 = hexToColor('#334A6127');

  static Color darkScaffoldBackgroundColor = hexToColor('#2F2E2E');
  static Color secondaryAppColor = hexToColor('#5E92F3');
  static Color colorItemWhiteShade = hexToColor('#FDFEFE');
  static Color colorShadow = hexToColor('#e7e7e7');

  static Color whiteColor = Colors.white;
  static Color blackColor = Colors.black;

  static Color buttonBorderColor = hexToColor('#809068');
  static Color buttonBgColor = Colors.purple;
  static Color buttonTextColor = hexToColor('#FFFFFF');

  static Color hintColor = hexToColor('#ADACBF');
  static Color lineBorderColor = hexToColor('#C5C4D8');

  static Color clickTextColor = hexToColor('#809068');
  static Color dividerColorYellow = hexToColor('#F4C264');
  static Color title2Color = hexToColor('#022136');
  static Color colorGreen = hexToColor('#8CBC42');
  static Color colorDim = hexToColor('#9FAEB9');

  static Color colorBlack69 = hexToColor('#B0022136');
  static Color colorDivider2 = hexToColor('#707070');
  static Color colorOrange = hexToColor('#FDA124');

  static Color colorNavActive = hexToColor('#4A6127');
  static Color colorNavInactive = hexToColor('#C5C4D8');
}
