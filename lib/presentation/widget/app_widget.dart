import 'package:flutter/material.dart';
import 'package:flutter_todo_app/res/app_context_extension.dart';

class AppWidget {
  static getCenterLoadingView() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  static getBuildNoResult(BuildContext context, String errorMessage) {
    return Padding(
      padding: EdgeInsets.all(context.resources.dimension.defaultMargin),
      child: Center(
        child: Text(errorMessage),
      ),
    );
  }

  static getDefaultSizedBox(BuildContext context) {
    return SizedBox(
      height: context.resources.dimension.defaultMargin,
    );
  }

  static defaultSnackBar(String message){
    return SnackBar(
        content: Text(message)
    );
  }
}