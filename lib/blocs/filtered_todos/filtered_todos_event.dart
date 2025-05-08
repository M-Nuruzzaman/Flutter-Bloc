part of 'filtered_todos_bloc.dart';

sealed class FilteredTodosEvent extends Equatable {
  const FilteredTodosEvent();

  @override
  List<Object> get props => [];
}

class CalculateFilteredTodos extends FilteredTodosEvent {
  final List<Todo> filteredTodos;

  const CalculateFilteredTodos({required this.filteredTodos});

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [filteredTodos];
}
