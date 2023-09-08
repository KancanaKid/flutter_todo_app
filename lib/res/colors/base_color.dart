import 'package:flutter/material.dart';

abstract class BaseColor {

  // theme color
  MaterialColor get colorPrimary;
  MaterialColor get colorAccent;

  // text color
  Color get colorPrimaryText;
  Color get colorSecondaryText;
  Color get colorAppbarTitleText;

  // extra color
  Color get colorLink;
  Color get colorBg;
  Color get countryBottomLabel;
  Color get countrySelectionBorderColor;
}