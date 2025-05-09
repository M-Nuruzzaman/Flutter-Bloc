import 'package:equatable/equatable.dart';

class ActiveTodoCountState extends Equatable {
  final int activeTodoCount;
  const ActiveTodoCountState({
    required this.activeTodoCount,
  });
  factory ActiveTodoCountState.initial() {
    return ActiveTodoCountState(activeTodoCount: 0);
  }

  @override
  List<Object> get props => [activeTodoCount];

  @override
  bool get stringify => true;

  ActiveTodoCountState copyWith({
    int? activeTodoCount,
  }) {
    return ActiveTodoCountState(
      activeTodoCount: activeTodoCount ?? this.activeTodoCount,
    );
  }
}
