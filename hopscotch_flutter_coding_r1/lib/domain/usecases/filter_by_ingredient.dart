import '../entities/meal.dart';
import '../repositories/meal_repository.dart';

class FilterByIngredient {
  final MealRepository repository;
  FilterByIngredient(this.repository);

  Future<List<MealEntity>> call(String ingredient) {
    return repository.getMealsByIngredient(ingredient);
  }
}
