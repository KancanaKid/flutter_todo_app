
abstract class TaskEvent {}

class FetchTasksEvent extends TaskEvent {
  FetchTasksEvent();
}

class AddTaskEvent extends TaskEvent{
  final String? title;
  final String? description;
  final String? dueDate;
  final bool isComplete;
  AddTaskEvent(this.title, this.description, this.dueDate, this.isComplete);
}

class EditTaskEvent extends TaskEvent{
  final String? id;
  final String? title;
  final String? description;
  final String? dueDate;
  final bool isComplete;
  EditTaskEvent(this.id, this.title, this.description, this.dueDate, this.isComplete);
}

class DeleteTaskEvent extends TaskEvent{
  final String? id;
  DeleteTaskEvent(this.id);
}

class EditStatusEvent extends TaskEvent{
  final String? id;
  final bool isComplete;
  EditStatusEvent(this.id, this.isComplete);
}