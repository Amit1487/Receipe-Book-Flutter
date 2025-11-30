// lib/presentation/state/search_meals_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/meal.dart';
import '../../domain/usecases/search_meals.dart';
import 'search_meals_state.dart';

class SearchMealsNotifier extends StateNotifier<SearchMealsState> {
  final SearchMeals _searchMeals;

  SearchMealsNotifier(this._searchMeals) : super(const SearchMealsState());

  Future<void> search(String query) async {
    state = state.copyWith(isLoading: true, error: null, visibleCount: 4);
    try {
      final results = await _searchMeals(query);
      state = state.copyWith(
        allMeals: results,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e);
    }
  }

  void loadMore() {
    final current = state.visibleCount;
    final total = state.allMeals.length;
    if (current >= total) return;

    final next = (current + 4) > total ? total : current + 4;
    state = state.copyWith(visibleCount: next);
  }
}