import 'package:flutter/material.dart';
import 'package:flutter_todo_app/res/resources.dart';

extension AppContext on BuildContext {
  Resources get resources => Resources.of(this);
}