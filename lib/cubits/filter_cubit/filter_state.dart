import 'package:equatable/equatable.dart';
import 'package:todo_cubit/models/todo_model.dart';

class FilterState extends Equatable {
  final Filter filter;
  const FilterState({
    required this.filter,
  });

  factory FilterState.initial() {
    return FilterState(filter: Filter.all);
  }

  @override
  List<Object> get props => [filter];

  @override
  bool get stringify => true;

  FilterState copyWith({
    Filter? filter,
  }) {
    return FilterState(
      filter: filter ?? this.filter,
    );
  }
}
