import '../entities/cousine.dart';
import '../repositories/meal_repository.dart';

class GetCuisine {
  final MealRepository repository;
  GetCuisine(this.repository);

  Future<List<CousinEntity>> call() async {
    final meals = await repository.getMealsByCountry('Canadian');
    return meals
        .map((m) => CousinEntity(id: m.id, name: m.name, imageUrl: m.imageUrl))
        .toList();
  }
}
