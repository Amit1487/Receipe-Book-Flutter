import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:hopscotch_flutter_coding_r1/core/network/api_service.dart';
import 'package:hopscotch_flutter_coding_r1/domain/repositories/meal_repository.dart';
import 'package:hopscotch_flutter_coding_r1/domain/entities/meal.dart';
import 'package:hopscotch_flutter_coding_r1/domain/entities/category.dart';
import 'package:hopscotch_flutter_coding_r1/domain/entities/cousine.dart';

/// Mock API Service for testing
class MockApiService extends Mock implements ApiService {}

/// Mock Dio for testing
class MockDio extends Mock implements Dio {}

/// Mock Repository for testing
class MockMealRepository extends Mock implements MealRepository {}

/// Fallback mocks for Response
class FakeResponse extends Fake implements Response {
  final dynamic data;
  final int? statusCode;

  FakeResponse({this.data, this.statusCode = 200});

  @override
  String toString() => 'FakeResponse(data: $data, statusCode: $statusCode)';
}

/// Setup fallback values for mocktail to avoid "no fallback value" errors
void setupFallbackValues() {
  registerFallbackValue(FakeResponse());
}
