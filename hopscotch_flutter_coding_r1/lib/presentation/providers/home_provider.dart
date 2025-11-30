import 'package:hopscotch_flutter_coding_r1/domain/entities/cousine.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/get_meal_details.dart';
import '../../domain/usecases/get_random_meals.dart';
import '../../domain/usecases/get_categories.dart';
import '../../domain/usecases/get_cuisine.dart';
import '../../../domain/entities/meal.dart';
import '../../../domain/entities/category.dart';
import '../../../core/di/providers.dart';
import '../../domain/usecases/search_meals.dart';
import '../state/search_meals_notifier.dart';

part 'home_provider.g.dart';

@riverpod
Future<List<MealEntity>> randomMeals(Ref ref) async {
  final usecase = GetRandomMeals(ref.read(mealRepositoryProvider));
  return usecase();
}

@riverpod
Future<List<CategoryEntity>> categories(Ref ref) async {
 final usecase = GetCategories(ref.read(mealRepositoryProvider));
  return usecase();
}

@riverpod
Future<List<CousinEntity>> cousine(Ref ref) async {
final usecase = GetCuisine(ref.read(mealRepositoryProvider));
  return usecase();
}

@riverpod
Future<List<MealEntity>> mealDetails(Ref ref, String mealId) async {
 final repo = ref.read(mealRepositoryProvider);
  final usecase = GetMealDetails(repo);
  return usecase(mealId);
}

// final searchMealsNotifierProvider =
//     StateNotifierProvider<SearchMealsNotifier, SearchMealsState>((ref) {
//   final repo = ref.read(mealRepositoryProvider);
//   final usecase = SearchMeals(repo);
//   return SearchMealsNotifier(usecase);
// });

@riverpod
Future<SearchMealsNotifier> search(Ref ref, String mealId) async {
 final repo = ref.read(mealRepositoryProvider);
  final usecase = SearchMeals(repo);
  return SearchMealsNotifier(usecase);
}