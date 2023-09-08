import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/bloc/task_event.dart';
import 'package:flutter_todo_app/bloc/task_state.dart';
import 'package:flutter_todo_app/domain/model/task.dart';
import 'package:flutter_todo_app/domain/repository/task_repository_imp.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState>{

  final _taskRepository = TaskRepositoryImp();
  late final Task task;

  TaskBloc():super(InitialState()){
    on<FetchTasksEvent>(_fetchTasks);
    on<AddTaskEvent>(_addTask);
    on<EditTaskEvent>(_editTask);
    on<DeleteTaskEvent>(_deleteTask);
    on<EditStatusEvent>(_editStatusTask);
  }

  FutureOr<void> _addTask(TaskEvent event, Emitter<TaskState> emit) async{
    emit(PageLoadingState());
    if(event is AddTaskEvent){
      await _taskRepository.writeTask(event.title!, event.description!, event.dueDate!, event.isComplete)
          .onError((error, stackTrace) => emit(TaskErrorState(error.toString())))
          .then((value) {
        emit(TaskQuerySuccessfulState("Task added"));
      });
    }

  }

  FutureOr<void> _fetchTasks(TaskEvent event, Emitter<TaskState> emit) async{
    if(event is FetchTasksEvent){
      emit(PageLoadingState());
      await _taskRepository.getTasks().onError((error, stackTrace) => emit(TaskErrorState(error.toString())))
      .then((value) {
        final List<Task> result = value as List<Task>;
        emit(PageLoadedState(result));
      });
    }
  }

  FutureOr<void> _deleteTask(TaskEvent event, Emitter<TaskState> emit) async{
    emit(PageLoadingState());
    if(event is DeleteTaskEvent){
      await _taskRepository.deleteTask(event.id!).onError((error, stackTrace) => emit(TaskErrorState(error.toString())))
          .then((value) {
        emit(TaskQuerySuccessfulState("Task deleted"));
      });
    }
  }

  FutureOr<void> _editTask(TaskEvent event, Emitter<TaskState> emit) async{
    emit(PageLoadingState());
    if(event is EditTaskEvent){
      task = Task(id: event.id!, title: event.title!, description: event.description!, dueDate: event.dueDate!, isComplete: event.isComplete);
      await _taskRepository.updateTask(task)
          .onError((error, stackTrace) => emit(TaskErrorState(error.toString())))
          .then((value) {
        emit(TaskQuerySuccessfulState("Task edited"));
      });
    }
  }

  FutureOr<void> _editStatusTask(TaskEvent event, Emitter<TaskState> emit) async{
    if(event is EditStatusEvent){
      await _taskRepository.updateStatus(event.id!, event.isComplete)
          .onError((error, stackTrace) => emit(TaskErrorState(error.toString())))
          .then((value) {
            final message = (event.isComplete) ? "Task completed" : "Task Uncompleted";
        emit(TaskQuerySuccessfulState(message));
        add(FetchTasksEvent());
      });
    }
  }

}