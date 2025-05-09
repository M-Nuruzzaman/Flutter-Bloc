import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../models/todo_model.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({super.key});

  List<Todo> setFilteredTodos(
      Filter filter, List<Todo> todos, String searchTerm) {
    List<Todo> _filteredTodos;

    switch (filter) {
      case Filter.active:
        _filteredTodos = todos.where((Todo todo) => !todo.completed).toList();
      case Filter.completed:
        _filteredTodos = todos.where((Todo todo) => todo.completed).toList();
      case Filter.all:
      default:
        _filteredTodos = todos;
        break;
    }
    if (searchTerm.isNotEmpty) {
      _filteredTodos = _filteredTodos
          .where((Todo todo) => todo.desc.toLowerCase().contains(searchTerm))
          .toList();
    }

    return _filteredTodos;
  }

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodosBloc>().state.filteredTodos;

    return MultiBlocListener(
      listeners: [
        BlocListener<TodoListBloc, TodoListState>(listener: (context, state) {
          final filteredTodos = setFilteredTodos(
              context.read<TodoFilterBloc>().state.filter,
              state.todos,
              context.read<TodoSearchBloc>().state.searchTerm);
          context
              .read<FilteredTodosBloc>()
              .add(CalculateFilteredTodos(filteredTodos: filteredTodos));
        }),
        BlocListener<TodoFilterBloc, TodoFilterState>(
            listener: (context, state) {
          final filteredTodos = setFilteredTodos(
              state.filter,
              context.read<TodoListBloc>().state.todos,
              context.read<TodoSearchBloc>().state.searchTerm);
          context
              .read<FilteredTodosBloc>()
              .add(CalculateFilteredTodos(filteredTodos: filteredTodos));
        }),
        BlocListener<TodoSearchBloc, TodoSearchState>(
            listener: (context, state) {
          final filteredTodos = setFilteredTodos(
            context.read<TodoFilterBloc>().state.filter,
            context.read<TodoListBloc>().state.todos,
            state.searchTerm,
          );
          context
              .read<FilteredTodosBloc>()
              .add(CalculateFilteredTodos(filteredTodos: filteredTodos));
        }),
      ],
      child: ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemCount: todos.length,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(color: Colors.grey);
        },
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: ValueKey(todos[index].id),
            background: showBackground(0),
            secondaryBackground: showBackground(1),
            confirmDismiss: (_) async {
              final confirm = await showDialog<bool>(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Are you sure?'),
                    content: Text('Do you really want to delete?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text('NO'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: Text('YES'),
                      ),
                    ],
                  );
                },
              );
              return confirm ?? false;
            },
            onDismissed: (_) {
              context
                  .read<TodoListBloc>()
                  .add(RemoveTodoEvent(todo: todos[index]));
            },
            child: TodoItem(todo: todos[index]),
          );
        },
      ),
    );
  }

  Widget showBackground(int direction) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      color: Colors.red,
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: Icon(
        Icons.delete,
        size: 30,
        color: Colors.white,
      ),
    );
  }
}

class TodoItem extends StatefulWidget {
  final Todo todo;
  const TodoItem({
    super.key,
    required this.todo,
  });

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late final TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              bool _error = false;
              textController.text = widget.todo.desc;

              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return AlertDialog(
                  title: Text('Edit todo'),
                  content: TextField(
                    controller: textController,
                    autocorrect: true,
                    decoration: InputDecoration(
                      errorText: _error ? "Value connot be empty" : null,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('CANCEL'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _error = textController.text.isEmpty ? true : false;
                          if (!_error) {
                            context.read<TodoListBloc>().add(EditTodoEvent(
                                id: widget.todo.id,
                                todoDesc: textController.text));
                            Navigator.pop(context);
                          }
                        });
                      },
                      child: Text('EDIT'),
                    ),
                  ],
                );
              });
            });
      },
      leading: Checkbox(
        value: widget.todo.completed,
        onChanged: (bool? checked) {
          context.read<TodoListBloc>().add(ToggleTodoEvent(id: widget.todo.id));
        },
      ),
      title: Text(widget.todo.desc),
    );
  }
}
