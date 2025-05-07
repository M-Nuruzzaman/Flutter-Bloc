import 'package:bloc/bloc.dart';
import 'package:todo_cubit/cubits/filter_cubit/filter_state.dart';
import 'package:todo_cubit/models/todo_model.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterState.initial());

  void changeFilter(Filter newFilter) {
    emit(state.copyWith(filter: newFilter));
  }
}
