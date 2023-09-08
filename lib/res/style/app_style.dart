
import 'package:flutter/material.dart';

import '../colors/app_color.dart';
import '../dimensions/app_dimension.dart';

class AppStyle {

  TextStyle headingTextStyle =
  TextStyle(fontSize: AppDimension().defaultText, fontWeight: FontWeight.bold, color: AppColor().colorPrimaryText);

  TextStyle headingLineThroughTextStyle =
  TextStyle(fontSize: AppDimension().defaultText, fontWeight: FontWeight.bold, color: AppColor().colorPrimaryText, decoration: TextDecoration.lineThrough);

  TextStyle subHeadingTextStyle =
  TextStyle(fontSize: AppDimension().mediumText, fontWeight: FontWeight.w600, color: AppColor().colorSecondaryText);

  TextStyle appbarTitleStyle =
  TextStyle(fontSize: AppDimension().defaultText, fontWeight: FontWeight.w600, color: AppColor().colorAppbarTitleText);

  TextStyle linkTextStyle =
  TextStyle(fontSize: AppDimension().defaultText, fontWeight: FontWeight.w600, color: AppColor().colorLink);

  TextStyle whiteTextStyle =
  TextStyle(fontSize: AppDimension().defaultText, fontWeight: FontWeight.w600, color: Colors.white);

  TextStyle whiteTextSmallStyle =
  TextStyle(fontSize: AppDimension().smallText, fontWeight: FontWeight.w600, color: Colors.white);

  TextStyle drawerTextStyle =
  TextStyle(fontSize: AppDimension().mediumText, fontWeight: FontWeight.w600, color: AppColor().colorAppbarTitleText);

  TextStyle drawerSubTextStyle =
  TextStyle(fontSize: AppDimension().mediumText, fontWeight: FontWeight.w400, color: AppColor().colorPrimary.shade900);

  IconThemeData appbarIconTheme =
  IconThemeData(color: AppColor().colorAppbarTitleText);
}