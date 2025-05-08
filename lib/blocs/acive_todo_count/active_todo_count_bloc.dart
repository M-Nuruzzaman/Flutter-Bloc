import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'active_todo_count_state.dart';

part 'active_todo_count_event.dart';

class ActiveTodoCountBloc
    extends Bloc<ActiveTodoCountEvent, ActiveTodoCountState> {
  final int initialActiveTodoCount;

  ActiveTodoCountBloc({
    required this.initialActiveTodoCount,
  }) : super(ActiveTodoCountState(activeTodoCount: initialActiveTodoCount)) {
    on<CalculateActiveTodoCountEvent>((event, emit) {
      emit(state.copyWith(activeTodoCount: event.activeTodoCount));
    });
  }
}
