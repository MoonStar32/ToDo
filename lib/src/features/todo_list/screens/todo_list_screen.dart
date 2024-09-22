import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/src/common/models/todo_model.dart';
import 'package:todo/src/features/theme/widgets/change_theme_button.dart';
import 'package:todo/src/features/todo_list/widgets/todo_item.dart';

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({
    super.key,
  });

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  final List<ToDo> todoList = [];
  List<ToDo> _foundToDo = [];
  final TextEditingController _todoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadToDoList();
  }

  Future<void> _loadToDoList() async {
    final prefs = await SharedPreferences.getInstance();
    final String? todoString = prefs.getString('todos');
    if (todoString != null) {
      final List<dynamic> todoJson = json.decode(todoString);
      setState(() {
        todoList.addAll(
          todoJson
              .map(
                (json) => ToDo.fromjson(json),
              )
              .toList(),
        );
        _foundToDo = todoList;
      });
    }
  }

  Future<void> _saveToDoList() async {
    final prefs = await SharedPreferences.getInstance();
    final String todoString = json.encode(
      todoList
          .map(
            (todo) => todo.toJson(),
          )
          .toList(),
    );

    await prefs.setString('todos', todoString);
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todoList.removeWhere(
        (item) => item.id == id,
      );
    });
    _saveToDoList();
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
    _saveToDoList();
  }

  void _addToDoItem(String todo) {
    if (todo.isNotEmpty) {
      setState(() {
        final newToDo = ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          toDoText: todo,
        );
        todoList.add(newToDo);
        _foundToDo = todoList;
      });
      _todoController.clear();
      FocusScope.of(context).unfocus();
      _saveToDoList();
    }
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> result = [];
    if (enteredKeyword.isEmpty) {
      result = todoList;
    } else {
      result = todoList
          .where(
            (item) => item.toDoText!.toLowerCase().contains(
                  enteredKeyword.toLowerCase(),
                ),
          )
          .toList();
    }
    setState(() {
      _foundToDo = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
            leading: const Icon(
              Icons.settings,
              size: 30,
            ),
          ),
          body: const Center(
            child: ChangeThemeButton(),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    onChanged: (value) => _runFilter(value),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 20,
                      ),
                      prefixIconConstraints: BoxConstraints(
                        maxHeight: 20,
                        maxWidth: 25,
                      ),
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 50,
                          bottom: 20,
                        ),
                        child: const Text(
                          'All ToDos',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      for (ToDo todoo in _foundToDo.reversed)
                        ToDoItem(
                          onToDoChanged: _handleToDoChange,
                          onDeleteItem: _deleteToDoItem,
                          todo: todoo,
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 0),
                          blurRadius: 10,
                          spreadRadius: 0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: const InputDecoration(
                        hintText: 'Добавить новую задачу',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      _addToDoItem(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      minimumSize: const Size(60, 60),
                      elevation: 10,
                    ),
                    child: const Text(
                      '+',
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
