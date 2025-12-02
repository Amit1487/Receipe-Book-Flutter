// lib/presentation/providers/search_meals_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/di/providers.dart'; // mealRepositoryProvider
import '../../domain/usecases/search_meals.dart';
import '../../domain/usecases/filter_by_category.dart';
import '../../domain/usecases/filter_by_ingredient.dart';
import '../../domain/usecases/filter_by_country.dart';
import '../state/search_meals_state.dart';
import '../state/search_meals_notifier.dart';

final searchMealsNotifierProvider =
    StateNotifierProvider<SearchMealsNotifier, SearchMealsState>((ref) {
  final repo = ref.read(mealRepositoryProvider);
  final searchUsecase = SearchMeals(repo);
  final filterByCategory = FilterByCategory(repo);
  final filterByIngredient = FilterByIngredient(repo);
  final filterByCountry = FilterByCountry(repo);
  return SearchMealsNotifier(
    searchUsecase,
    filterByCategory,
    filterByIngredient,
    filterByCountry,
  );
});
