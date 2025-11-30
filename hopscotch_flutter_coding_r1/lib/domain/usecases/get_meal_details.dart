import '../entities/meal.dart';
import '../repositories/meal_repository.dart';

class GetMealDetails {
  final MealRepository repository;

  GetMealDetails(this.repository);

  Future<List<MealEntity>> call(String idMeal) {
    return repository.getMealDetails(idMeal);
  }
}
