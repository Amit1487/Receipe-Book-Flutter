import '../entities/cousine.dart';  // ← Updated import
import '../repositories/meal_repository.dart';

class GetCuisine {
  final MealRepository repository;
  GetCuisine(this.repository);

  Future<List<CousinEntity>> call() => repository.getMealsByCountry("Canadian");  // ← Updated return type
}
