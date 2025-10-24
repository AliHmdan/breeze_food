import 'package:breezefood/data/model/search/search_history_model.dart';
import 'package:breezefood/data/model/search/search_result_model.dart';
import 'package:equatable/equatable.dart';


abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchHistoryLoaded extends SearchState {
  final List<SearchHistoryModel> history;

  const SearchHistoryLoaded(this.history);

  @override
  List<Object?> get props => [history];
}

class SearchResultLoaded extends SearchState {
  final SearchResultModel result;

  const SearchResultLoaded(this.result);

  @override
  List<Object?> get props => [result];
}

class SearchFailure extends SearchState {
  final String error;

  const SearchFailure(this.error);

  @override
  List<Object?> get props => [error];
}