import 'package:flutter_todo_app/domain/model/task.dart';

abstract class TaskRepository {
  Future<dynamic> writeTask(String title, String description, String dueDate, bool isComplete);
  Future<dynamic> getTasks();
  Future<dynamic> deleteTask(String task);
  Future<dynamic> updateTask(Task task);
  Future<dynamic> updateStatus(String id, bool isComplete);
}