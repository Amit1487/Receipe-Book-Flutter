import '../entities/meal.dart';
import '../repositories/meal_repository.dart';

class FilterByCategory {
  final MealRepository repository;
  FilterByCategory(this.repository);

  Future<List<MealEntity>> call(String category) {
    return repository.getMealsByCategory(category);
  }
}
