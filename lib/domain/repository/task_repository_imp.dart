
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_todo_app/domain/firebase/firebase_manager.dart';
import 'package:flutter_todo_app/domain/model/task.dart';
import 'package:flutter_todo_app/domain/repository/task_repository.dart';

class TaskRepositoryImp extends TaskRepository{
  @override
  Future deleteTask(String task) async{
   try{
     return await FirebaseManager.databaseReference("tasks/$task").remove();
   }catch(e){
     rethrow;
   }
  }

  @override
  Future getTasks() async{
    final List<Task> list = [];
    try{
       final Query query = FirebaseManager.databaseReference("tasks").orderByValue();
       query.onChildAdded.forEach((element) {
         list.add(Task.fromMap(element.snapshot.value as Map));
       });

       return await query.once().then((value) => list);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future writeTask(String title, String description, String dueDate, bool isComplete) async{
    final String? newKey = FirebaseManager.databaseReference("tasks").push().key;
    try{
      final newTask = Task(id: newKey!, title: title, description: description, dueDate: dueDate, isComplete:isComplete);
      return await FirebaseManager.databaseReference("tasks/$newKey").set(
        newTask.toJson()
      );
    }catch(e){
      rethrow;
    }
  }

  @override
  Future updateTask(Task task) async{
    try{
      return await FirebaseManager.databaseReference("tasks/${task.id}").update(
        task.toJson()
      );
    }catch(e){
      rethrow;
    }
  }

  @override
  Future updateStatus(String id, bool isComplete) async {
    try{
      return await FirebaseManager.databaseReference("tasks/$id").update(
        {
          "is_complete" : isComplete
        }
      );
    }catch(e){
      rethrow;
    }
  }


  
}