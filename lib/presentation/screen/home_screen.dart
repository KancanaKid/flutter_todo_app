import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/bloc/task_bloc.dart';
import 'package:flutter_todo_app/bloc/task_event.dart';
import 'package:flutter_todo_app/bloc/task_state.dart';
import 'package:flutter_todo_app/domain/model/task.dart';
import 'package:flutter_todo_app/presentation/adapter/task_adapter.dart';
import 'package:flutter_todo_app/presentation/screen/add_task_screen.dart';
import 'package:flutter_todo_app/presentation/screen/detail_task_screen.dart';
import 'package:flutter_todo_app/presentation/widget/app_widget.dart';
import 'package:flutter_todo_app/res/app_context_extension.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TaskBloc _taskBloc;

  FutureOr _getRefresh(dynamic value){
    setState(() {});
  }

  @override
  void initState() {
    _taskBloc = BlocProvider.of(context);
    _taskBloc.add(FetchTasksEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: context.resources.style.appbarIconTheme,
        centerTitle: true,
        title: Text(
          "Todo App",
          style: context.resources.style.appbarTitleStyle,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: context.resources.color.colorBg,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(AddTaskScreen.id).then(_getRefresh);
        },
      ),
      body: BlocConsumer<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is PageLoadingState) {
            return AppWidget.getCenterLoadingView();
          } else if (state is PageLoadedState) {
            return TaskAdapter(
                task: state.tasks,
                onItemChangeStatus: (Task task) {
                  _taskBloc.add(EditStatusEvent(task.id!, task.isComplete));
                },
              onItemSelected: (Task task){
                Navigator.of(context).pushNamed(DetailTaskScreen.id, arguments: task).then(_getRefresh);
              },
            );
          } else if (state is TaskErrorState) {
            return AppWidget.getBuildNoResult(context, state.errorMessage);
          }
          return AppWidget.getCenterLoadingView();
        },
        listener: (context, state) {
          if (state is TaskErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(AppWidget.defaultSnackBar(state.errorMessage));
          } else if (state is TaskQuerySuccessfulState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(AppWidget.defaultSnackBar(state.message));
          }
        },
      ),
    );
  }
}
