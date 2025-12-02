import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<Response> getRandomMeals() => _dio.get('/random.php');
  Future<Response> getCategories() => _dio.get('/categories.php');
  Future<Response> getMealDetails(String id) => _dio.get('/lookup.php?i=$id');
  Future<Response> getMealsByCountry(String country) => _dio.get(
      '/filter.php?a=Canadian'); // hard coded as it gives empty list for all other inputs
  Future<Response> getMealsByCategory(String category) =>
      _dio.get('/filter.php?c=$category');
  Future<Response> getMealsByIngredient(String ingredient) =>
      _dio.get('/filter.php?i=$ingredient');
  Future<Response> searchMeals(String query) =>
      _dio.get('/search.php?s=$query');
  Future<Response> getCountries() => _dio.get('/list.php?a=list');
}
