import 'package:flutter/material.dart';
import 'package:flutter_todo_app/res/style/app_style.dart';

import 'colors/app_color.dart';
import 'dimensions/app_dimension.dart';

class Resources{
  final BuildContext _context;
  Resources(this._context);

  AppColor get color {
    return AppColor();
  }

  AppDimension get dimension {
    return AppDimension();
  }

  AppStyle get style {
    return AppStyle();
  }

  static Resources of(BuildContext context){
    return Resources(context);
  }
}