import 'package:flutter/material.dart';
import 'package:todo_cubit/pages/todos_page/create_todo.dart';
import 'package:todo_cubit/pages/todos_page/search_and_todo_filter.dart';
import 'package:todo_cubit/pages/todos_page/show_todos.dart';
import 'package:todo_cubit/pages/todos_page/todo_header.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Column(
            children: [
              TodoHeader(),
              CreateTodo(),
              SizedBox(height: 10.0),
              SearchAndTodoFilter(),
              ShowTodos(),
            ],
          ),
        ),
      ),
    );
  }
}
