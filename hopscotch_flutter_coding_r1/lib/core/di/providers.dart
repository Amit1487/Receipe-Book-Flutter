import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/api_service.dart';
import '../../data/repositories/meal_repository_impl.dart';
import '../../domain/repositories/meal_repository.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://www.themealdb.com/api/json/v1/1',
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    ),
  );
  return dio;
});

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(ref.read(dioProvider));
});

final mealRepositoryProvider = Provider<MealRepository>((ref) {
  return MealRepositoryImpl(ref.read(apiServiceProvider));
});
