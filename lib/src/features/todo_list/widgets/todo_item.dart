import 'package:flutter/material.dart';
import 'package:todo/src/common/models/todo_model.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final dynamic onToDoChanged;
  final dynamic onDeleteItem;

  const ToDoItem({
    super.key,
    required this.onToDoChanged,
    required this.onDeleteItem,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      child: ListTile(
        onTap: () {
          onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        tileColor: Colors.white,
        title: Text(
          todo.toDoText!,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
        ),
        trailing: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 12,
          ),
          padding: const EdgeInsets.all(0),
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: const Icon(
              Icons.delete,
            ),
            onPressed: () {
              onDeleteItem(
                todo.id,
              );
            },
          ),
        ),
      ),
    );
  }
}
