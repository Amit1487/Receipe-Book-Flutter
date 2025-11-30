import '../entities/category.dart';
import '../repositories/meal_repository.dart';

class GetCategories {
  final MealRepository repository;
  GetCategories(this.repository);

  Future<List<CategoryEntity>> call() => repository.getCategories();
}
