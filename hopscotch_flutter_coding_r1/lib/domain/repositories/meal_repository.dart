import 'package:hopscotch_flutter_coding_r1/domain/entities/category.dart';

import '../entities/meal.dart';
import '../entities/cousine.dart';

abstract class MealRepository {
  Future<List<MealEntity>> getRandomMeals();
  Future<List<CategoryEntity>> getCategories();
  Future<List<MealEntity>> getMealDetails(String id);
  Future<List<MealEntity>> getMealsByCountry(String country);
  Future<List<MealEntity>> getMealsByCategory(String category);
  Future<List<MealEntity>> getMealsByIngredient(String ingredient);
  Future<List<MealEntity>> searchMeals(String query);
  Future<List<MealEntity>> getCountries();
}
