class ToDo {
  String? id;
  String? toDoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.toDoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(
        id: '01',
        toDoText: 'Моя первая задачка!!!',
        isDone: false,
      ),
    ];
  }

  factory ToDo.fromjson(Map<String, dynamic> json) {
    return ToDo(
      id: json['id'],
      toDoText: json['toDoText'],
      isDone: json['isDone'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'toDoText': toDoText,
        'isDone': isDone,
      };
}
