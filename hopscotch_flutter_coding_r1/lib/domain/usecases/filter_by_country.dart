import '../entities/meal.dart';
import '../repositories/meal_repository.dart';

class FilterByCountry {
  final MealRepository repository;
  FilterByCountry(this.repository);

  Future<List<MealEntity>> call(String country) {
    return repository.getMealsByCountry(country);
  }
}
