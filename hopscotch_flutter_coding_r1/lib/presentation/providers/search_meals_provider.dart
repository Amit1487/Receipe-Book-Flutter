// lib/presentation/providers/search_meals_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/di/providers.dart'; // mealRepositoryProvider
import '../../domain/usecases/search_meals.dart';
import '../state/search_meals_state.dart';
import '../state/search_meals_notifier.dart';

final searchMealsNotifierProvider =
    StateNotifierProvider<SearchMealsNotifier, SearchMealsState>((ref) {
  final repo = ref.read(mealRepositoryProvider);
  final usecase = SearchMeals(repo);
  return SearchMealsNotifier(usecase);
});
