import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/bloc/task_bloc.dart';
import 'package:flutter_todo_app/domain/model/task.dart';
import 'package:flutter_todo_app/presentation/screen/add_task_screen.dart';
import 'package:flutter_todo_app/presentation/screen/detail_task_screen.dart';
import 'package:flutter_todo_app/presentation/screen/home_screen.dart';

class RouteGenerator {
  Route<dynamic> generatorRoute(RouteSettings settings){
    final args = settings.arguments;

    switch(settings.name){
      case HomeScreen.id :
        return MaterialPageRoute(
            builder: (_) => BlocProvider<TaskBloc>.value(
              value: TaskBloc(),
              child: const HomeScreen(),
            )
        );
      case AddTaskScreen.id :
        return MaterialPageRoute(
            builder: (_) => BlocProvider<TaskBloc>.value(
              value: TaskBloc(),
              child: const AddTaskScreen(),
            )
        );
      case DetailTaskScreen.id:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<TaskBloc>.value(
              value: TaskBloc(),
              child: DetailTaskScreen(task: args as Task),
            )
        );
      default :
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Error while loading new page'),
        ),
      );
    });
  }
}