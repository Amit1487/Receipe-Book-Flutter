import 'package:dio/dio.dart';
import 'package:hopscotch_flutter_coding_r1/domain/entities/cousine.dart';
import '../../core/network/api_service.dart';
import '../../domain/entities/meal.dart';
import '../../../domain/entities/category.dart';
import '../../domain/repositories/meal_repository.dart';
import '../../data/models/meal_model.dart';
import '../../data/models/meal_details_model.dart';
import '../../data/models/category_model.dart';

class MealRepositoryImpl implements MealRepository {
  final ApiService _apiService;

  MealRepositoryImpl(this._apiService);

  @override
  Future<List<MealEntity>> getRandomMeals() async {
    final response = await _apiService.getRandomMeals();
    final data = response.data as Map<String, dynamic>;
    print("printing data  size is ${data.length} for meal api ${data}");
    final meals = (data['meals'] as List)
        .map((json) => MealModel.fromJson(json))
        .toList();
    return meals
        .map((model) => MealEntity(
              id: model.id,
              name: model.name,
              imageUrl: model.imageUrl,
            ))
        .toList();
  }

  @override
  Future<List<CategoryEntity>> getCategories() async {
    final response = await _apiService.getCategories();
    final data = response.data as Map<String, dynamic>;
    final categories = (data['categories'] as List)
        .map((json) => CategoryModel.fromJson(json))
        .toList();
    return categories
        .map((model) => CategoryEntity(
              id: model.id,
              name: model.name,
              imageUrl: model.imageUrl,
            ))
        .toList();
  }

  @override
  Future<List<MealEntity>> getMealDetails(String id) async {
    final response = await _apiService.getMealDetails(id);
    final data = response.data as Map<String, dynamic>;
    print("printing data  size is ${data.length} for meal api ${data}");
    final meals = (data['meals'] as List)
        .map((json) => MealDetailsModel.fromJson(json))
        .toList();
    return meals
        .map((model) => MealEntity(
              id: model.idMeal,
              name: model.strMeal,
              imageUrl: model.strMealThumb,
              instructions: model.strInstructions,
              ingredients: model.ingredients,
              category: model.strCategory,
              area: model.strArea,
            ))
        .toList();
  }

  @override
  Future<List<MealEntity>> getMealsByCountry(String country) async {
    final response = await _apiService.getMealsByCountry(country);
    final data = response.data as Map<String, dynamic>;
    print("getMealsByCountry country=$country response=$data");
    final meals = (data['meals'] as List)
        .map((json) => MealModel.fromJson(json))
        .toList();
    return meals
        .map((model) => MealEntity(
              id: model.id,
              name: model.name,
              imageUrl: model.imageUrl,
            ))
        .toList();
  }

  @override
  Future<List<MealEntity>> getMealsByCategory(String category) async {
    final response = await _apiService.getMealsByCategory(category);
    final data = response.data as Map<String, dynamic>;
    final meals = (data['meals'] as List)
        .map((json) => MealModel.fromJson(json))
        .toList();
    return meals
        .map((model) => MealEntity(
              id: model.id,
              name: model.name,
              imageUrl: model.imageUrl,
            ))
        .toList();
  }

  @override
  Future<List<MealEntity>> getMealsByIngredient(String ingredient) async {
    final response = await _apiService.getMealsByIngredient(ingredient);
    final data = response.data as Map<String, dynamic>;
    final meals = (data['meals'] as List)
        .map((json) => MealModel.fromJson(json))
        .toList();
    return meals
        .map((model) => MealEntity(
              id: model.id,
              name: model.name,
              imageUrl: model.imageUrl,
            ))
        .toList();
  }

  @override
  Future<List<MealEntity>> searchMeals(String query) async {
    final response = await _apiService.searchMeals(query);
    final data = response.data as Map<String, dynamic>;
    final meals = (data['meals'] as List?)
            ?.map((json) => MealModel.fromJson(json))
            .toList() ??
        [];
    return meals
        .map((model) => MealEntity(
              id: model.id,
              name: model.name,
              imageUrl: model.imageUrl,
            ))
        .toList();
  }

  @override
  Future<List<MealEntity>> getCountries() async {
    final response = await _apiService.getCountries();
    // Implement countries parsing
    return [];
  }
}
