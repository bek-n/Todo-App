class ToDoModel {
  final String title;
  bool isDone;

  ToDoModel({required this.title, this.isDone = false});

  factory ToDoModel.fromJson(Map todo) {
    return ToDoModel(title: todo['title'], isDone: todo['is_done'] ?? false);
  }
  Map toJson() {
    return {"title": title, "is_done": isDone};
  }
}
