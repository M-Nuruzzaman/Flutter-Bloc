// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:todo_cubit/cubits/search_cubit/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState.initial());

  void setSearchTerm(String newSearchTrem) {
    emit(state.copyWith(searchTerm: newSearchTrem));
  }
}
