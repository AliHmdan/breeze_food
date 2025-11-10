import 'package:freeza_food/data/repositories/search_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository searchRepository;

  SearchCubit(this.searchRepository) : super(SearchInitial());

  Future<void> loadSearchHistory() async {
    emit(SearchLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      
      if (token == null) {
        emit(const SearchFailure("No authentication token found"));
        return;
      }

      final history = await searchRepository.getSearchHistory(token);
      emit(SearchHistoryLoaded(history));
    } catch (e) {
      emit(SearchFailure("Failed to load search history: $e"));
    }
  }

  Future<void> performSearch(String query) async {
    emit(SearchLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      
      if (token == null) {
        emit(const SearchFailure("No authentication token found"));
        return;
      }

      final result = await searchRepository.performSearch(token, query);
      emit(SearchResultLoaded(result));
    } catch (e) {
      emit(SearchFailure("Failed to perform search: $e"));
    }
  }

  void clearState() {
    emit(SearchInitial());
  }
}