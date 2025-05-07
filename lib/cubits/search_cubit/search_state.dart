import 'package:equatable/equatable.dart';

class SearchState extends Equatable {
  final String searchTerm;
  const SearchState({
    required this.searchTerm,
  });

  factory SearchState.initial() {
    return SearchState(searchTerm: '');
  }

  @override
  List<Object> get props => [searchTerm];

  @override
  bool get stringify => true;

  SearchState copyWith({
    String? searchTerm,
  }) {
    return SearchState(
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }
}
