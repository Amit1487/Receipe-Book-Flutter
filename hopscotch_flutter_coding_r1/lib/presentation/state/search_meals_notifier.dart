// lib/presentation/state/search_meals_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/meal.dart';
import '../../domain/usecases/filter_by_category.dart';
import '../../domain/usecases/filter_by_ingredient.dart';
import '../../domain/usecases/filter_by_country.dart';
import 'search_meals_state.dart';

class SearchMealsNotifier extends StateNotifier<SearchMealsState> {
  final FilterByCategory _filterByCategory;
  final FilterByIngredient _filterByIngredient;
  final FilterByCountry _filterByCountry;

  SearchMealsNotifier(
    this._filterByCategory,
    this._filterByIngredient,
    this._filterByCountry,
  ) : super(const SearchMealsState());

  Future<void> search(String query) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
      visibleCountCategory: 4,
      visibleCountIngredient: 4,
      visibleCountCuisine: 4,
    );

    try {
      // Fetch filter lists in parallel and update state when all complete.
      final responses = await Future.wait<List<MealEntity>>([
        _filterByCategory(query).catchError((_) => <MealEntity>[]),
        _filterByIngredient(query).catchError((_) => <MealEntity>[]),
        _filterByCountry(query).catchError((_) => <MealEntity>[]),
      ]);

      final categoryList = responses[0];
      final ingredientList = responses[1];
      final cuisineList = responses[2];

      state = state.copyWith(
        categoryList: categoryList,
        ingredientList: ingredientList,
        cuisineList: cuisineList,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e);
    }
  }

  void loadMore() {
    // Removed: pagination for allMeals is not required anymore.
    return;
  }

  void loadMoreCategory() {
    final current = state.visibleCountCategory;
    final total = state.categoryList.length;
    if (current >= total) return;

    final next = (current + 4) > total ? total : current + 4;
    state = state.copyWith(visibleCountCategory: next);
  }

  void loadMoreIngredient() {
    final current = state.visibleCountIngredient;
    final total = state.ingredientList.length;
    if (current >= total) return;

    final next = (current + 4) > total ? total : current + 4;
    state = state.copyWith(visibleCountIngredient: next);
  }

  void loadMoreCuisine() {
    final current = state.visibleCountCuisine;
    final total = state.cuisineList.length;
    if (current >= total) return;

    final next = (current + 4) > total ? total : current + 4;
    state = state.copyWith(visibleCountCuisine: next);
  }
}