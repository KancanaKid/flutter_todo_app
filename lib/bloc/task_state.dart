import 'package:flutter_todo_app/domain/model/task.dart';

abstract class TaskState {}

class InitialState extends TaskState{}
class PageLoadingState extends TaskState{}
class PageLoadedState extends TaskState{
  late List<Task> tasks;
  PageLoadedState(this.tasks);
}
class TaskErrorState extends TaskState {
  late final String errorMessage;
  TaskErrorState(this.errorMessage);
}
class TaskQuerySuccessfulState extends TaskState {
  late final String message;
  TaskQuerySuccessfulState(this.message);
}
