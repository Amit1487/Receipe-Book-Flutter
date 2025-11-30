import '../entities/meal.dart';
import '../repositories/meal_repository.dart';

class SearchMeals {
  final MealRepository repository;
  SearchMeals(this.repository);

  Future<List<MealEntity>> call(String query) {
    return repository.searchMeals(query);
  }
}