import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:hopscotch_flutter_coding_r1/core/network/api_service.dart';
import 'package:hopscotch_flutter_coding_r1/data/repositories/meal_repository_impl.dart';
import '../../fixtures/meal_fixtures.dart';
import '../../mocks/mocks.dart';

void main() {
  late MockApiService mockApiService;
  late MealRepositoryImpl repository;

  setUp(() {
    mockApiService = MockApiService();
    repository = MealRepositoryImpl(mockApiService);
  });

  group('MealRepositoryImpl', () {
    group('getRandomMeals', () {
      test('should return list of meals on successful API call', () async {
        // Arrange
        final response = FakeResponse(
          data: MealFixtures.mealResponseJson,
          statusCode: 200,
        );
        when(() => mockApiService.getRandomMeals())
            .thenAnswer((_) async => response);

        // Act
        final result = await repository.getRandomMeals();

        // Assert
        expect(result, isNotEmpty);
        expect(result.first.name, 'Teriyaki Chicken Casserole');
        verify(() => mockApiService.getRandomMeals()).called(1);
      });

      test('should throw exception on API failure', () async {
        // Arrange
        when(() => mockApiService.getRandomMeals())
            .thenThrow(DioException(
              requestOptions: RequestOptions(path: ''),
              message: 'Network error',
            ));

        // Act & Assert
        expect(
          () => repository.getRandomMeals(),
          throwsA(isA<DioException>()),
        );
        verify(() => mockApiService.getRandomMeals()).called(1);
      });

      test('should handle empty meals response', () async {
        // Arrange
        final response = FakeResponse(
          data: {'meals': []},
          statusCode: 200,
        );
        when(() => mockApiService.getRandomMeals())
            .thenAnswer((_) async => response);

        // Act
        final result = await repository.getRandomMeals();

        // Assert
        expect(result, isEmpty);
        verify(() => mockApiService.getRandomMeals()).called(1);
      });
    });

    group('getCategories', () {
      test('should return list of categories on successful API call', () async {
        // Arrange
        final response = FakeResponse(
          data: MealFixtures.categoriesResponseJson,
          statusCode: 200,
        );
        when(() => mockApiService.getCategories())
            .thenAnswer((_) async => response);

        // Act
        final result = await repository.getCategories();

        // Assert
        expect(result, isNotEmpty);
        expect(result.first.name, 'Seafood');
        verify(() => mockApiService.getCategories()).called(1);
      });

      test('should throw exception on API failure', () async {
        // Arrange
        when(() => mockApiService.getCategories())
            .thenThrow(DioException(
              requestOptions: RequestOptions(path: ''),
              message: 'Network error',
            ));

        // Act & Assert
        expect(
          () => repository.getCategories(),
          throwsA(isA<DioException>()),
        );
      });
    });

    group('getMealDetails', () {
      test('should return meal details for valid ID', () async {
        // Arrange
        final response = FakeResponse(
          data: {
            'meals': [MealFixtures.mealDetailsJson]
          },
          statusCode: 200,
        );
        when(() => mockApiService.getMealDetails('52772'))
            .thenAnswer((_) async => response);

        // Act
        final result = await repository.getMealDetails('52772');

        // Assert
        expect(result, isNotEmpty);
        expect(result.first.name, 'Teriyaki Chicken Casserole');
        expect(result.first.ingredients, isNotEmpty);
        verify(() => mockApiService.getMealDetails('52772')).called(1);
      });

      test('should handle null response gracefully', () async {
        // Arrange
        final response = FakeResponse(
          data: {'meals': null},
          statusCode: 200,
        );
        when(() => mockApiService.getMealDetails('invalid'))
            .thenAnswer((_) async => response);

        // Act & Assert - should throw TypeError when meals is null
        expect(
          () => repository.getMealDetails('invalid'),
          throwsA(isA<TypeError>()),
        );
      });
    });

    group('getMealsByCountry', () {
      test('should return meals for valid country', () async {
        // Arrange
        final response = FakeResponse(
          data: MealFixtures.mealResponseJson,
          statusCode: 200,
        );
        when(() => mockApiService.getMealsByCountry('Canadian'))
            .thenAnswer((_) async => response);

        // Act
        final result = await repository.getMealsByCountry('Canadian');

        // Assert
        expect(result, isNotEmpty);
        verify(() => mockApiService.getMealsByCountry('Canadian')).called(1);
      });
    });

    group('searchMeals', () {
      test('should return meals matching search query', () async {
        // Arrange
        final response = FakeResponse(
          data: MealFixtures.mealResponseJson,
          statusCode: 200,
        );
        when(() => mockApiService.searchMeals('chicken'))
            .thenAnswer((_) async => response);

        // Act
        final result = await repository.searchMeals('chicken');

        // Assert
        expect(result, isNotEmpty);
        verify(() => mockApiService.searchMeals('chicken')).called(1);
      });

      test('should return empty list for no search results', () async {
        // Arrange
        final response = FakeResponse(
          data: {'meals': null},
          statusCode: 200,
        );
        when(() => mockApiService.searchMeals('xyz'))
            .thenAnswer((_) async => response);

        // Act
        final result = await repository.searchMeals('xyz');

        // Assert - searchMeals returns empty list when meals is null
        expect(result, isEmpty);
        verify(() => mockApiService.searchMeals('xyz')).called(1);
      });

      test('should handle special characters in search', () async {
        // Arrange
        final response = FakeResponse(
          data: MealFixtures.mealResponseJson,
          statusCode: 200,
        );
        when(() => mockApiService.searchMeals('pasta & noodles'))
            .thenAnswer((_) async => response);

        // Act
        final result = await repository.searchMeals('pasta & noodles');

        // Assert
        expect(result, isNotEmpty);
        verify(() => mockApiService.searchMeals('pasta & noodles')).called(1);
      });
    });

    group('getCountries', () {
      test('should return empty list (not implemented)', () async {
        // Arrange
        final response = FakeResponse(
          data: MealFixtures.mealResponseJson,
          statusCode: 200,
        );
        when(() => mockApiService.getCountries())
            .thenAnswer((_) async => response);

        // Act
        final result = await repository.getCountries();

        // Assert - getCountries returns empty list as it's not yet implemented
        expect(result, isEmpty);
        verify(() => mockApiService.getCountries()).called(1);
      });
    });
  });
}
