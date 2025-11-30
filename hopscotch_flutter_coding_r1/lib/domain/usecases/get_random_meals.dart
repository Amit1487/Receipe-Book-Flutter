import '../entities/meal.dart';
import '../repositories/meal_repository.dart';

class GetRandomMeals {
  final MealRepository repository;
  GetRandomMeals(this.repository);

  Future<List<MealEntity>> call() => repository.getRandomMeals();
}
