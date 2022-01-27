import 'package:flutter/material.dart';
import 'package:garage_locator/constants/color_constants.dart';
import 'package:garage_locator/provider/size-config.dart';

final double appBarIconsIZE = SizeConfig.blockSizeH! * 3.5;
final double halfScreen = SizeConfig.blockSizeH! * 49;
final double iconSize = SizeConfig.blockSizeH! * 2.8;

final onBoardingBodyText = TextStyle(
  wordSpacing: 2,
  letterSpacing: 1.5,
  fontSize: SizeConfig.blockSizeH! * 3,
  fontWeight: FontWeight.w700,
  color: appGreen,
);

final onBoardingStartText = TextStyle(
  wordSpacing: 2,
  fontSize: SizeConfig.blockSizeH! * 3.8,
  fontWeight: FontWeight.w800,
  color: appGreen,
);

final introTitle = TextStyle(
  fontSize: SizeConfig.blockSizeH! * 4.0,
  fontWeight: FontWeight.w800,
  wordSpacing: 2.6,
  color: appGreen,
);
final introBodyTitle = TextStyle(
    fontSize: SizeConfig.blockSizeH! * 3.4,
    fontWeight: FontWeight.w700,
    color: appGreen);

final introTerms = TextStyle(
    fontSize: SizeConfig.blockSizeH! * 1.6,
    fontWeight: FontWeight.w600,
    color: Colors.black);

final homePageHello = TextStyle(
  fontSize: SizeConfig.blockSizeH! * 3.2,
  fontWeight: FontWeight.w700,
);

final homePageDropDown = TextStyle(
  fontSize: SizeConfig.blockSizeH! * 2.3,
  fontWeight: FontWeight.w600,
);

final introTermsYellow = TextStyle(
  fontSize: SizeConfig.blockSizeH! * 1.6,
  fontWeight: FontWeight.w600,
  color: linkColor,
);

final signingOption = TextStyle(
  fontSize: SizeConfig.blockSizeH! * 2,
  fontWeight: FontWeight.w600,
  color: Colors.black,
);

final signingOptionBtn = TextStyle(
  fontSize: SizeConfig.blockSizeH! * 2,
  fontWeight: FontWeight.w600,
  color: linkColor,
);

final signingTxtBtn = TextStyle(
  fontSize: SizeConfig.blockSizeH! * 2.3,
  fontWeight: FontWeight.w600,
  color: linkColor,
);

final forgotPasswordStyle = TextStyle(
  fontSize: SizeConfig.blockSizeH! * 1.8,
  fontWeight: FontWeight.w500,
  color: linkColor,
);

final settingsBodyTitle = TextStyle(
    wordSpacing: 2,
    fontSize: SizeConfig.blockSizeH! * 2.1,
    fontWeight: FontWeight.w700,
    color: whiteBackground);

final appBarTitle = TextStyle(
    fontSize: SizeConfig.blockSizeH! * 3,
    wordSpacing: 2,
    fontWeight: FontWeight.w800,
    color: Colors.white);

final onBoardingBtn = TextStyle(
  wordSpacing: 2,
  fontSize: SizeConfig.blockSizeH! * 2,
  fontWeight: FontWeight.w600,
);

final myTextBtn = TextStyle(
  wordSpacing: 2,
  fontSize: SizeConfig.blockSizeH! * 2,
  fontWeight: FontWeight.w700,
  color: Colors.white,
);
