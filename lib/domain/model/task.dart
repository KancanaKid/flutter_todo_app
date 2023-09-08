class Task {
  String? id;
  String? title;
  String? description;
  String? dueDate;
  bool isComplete;

  Task({required this.id, required this.title,
    required this.description, required this.dueDate, required this.isComplete});

  factory Task.fromJson(Map<String, dynamic> json){
    return Task(id: json["id"], title: json["title"], description: json["description"], dueDate: json["due_date"], isComplete: json["is_complete"]);
  }

  static Task fromMap(Map json){
    return Task(id: json["id"], title: json["title"], description: json["description"], dueDate: json["due_date"], isComplete: json["is_complete"]);
  }

  Map<String, dynamic> toJson() => {
    "id" : id,
    "title":title,
    "description":description,
    "due_date":dueDate,
    "is_complete":isComplete
  };
}