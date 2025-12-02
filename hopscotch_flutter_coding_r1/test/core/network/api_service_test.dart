import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:hopscotch_flutter_coding_r1/core/network/api_service.dart';
import '../../mocks/mocks.dart';

void main() {
  late MockDio mockDio;
  late ApiService apiService;

  setUp(() {
    mockDio = MockDio();
    apiService = ApiService(mockDio);
  });

  group('ApiService', () {
    group('getRandomMeals', () {
      test('should call /random.php endpoint', () async {
        // Arrange
        final mockResponse = FakeResponse(
          data: {'meals': []},
          statusCode: 200,
        );
        when(() => mockDio.get('/random.php'))
            .thenAnswer((_) async => mockResponse);

        // Act
        final result = await apiService.getRandomMeals();

        // Assert
        expect(result.statusCode, 200);
        verify(() => mockDio.get('/random.php')).called(1);
      });

      test('should throw DioException on network error', () async {
        // Arrange
        when(() => mockDio.get('/random.php')).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/random.php'),
            message: 'Connection timeout',
          ),
        );

        // Act & Assert
        expect(
          () => apiService.getRandomMeals(),
          throwsA(isA<DioException>()),
        );
      });
    });

    group('getCategories', () {
      test('should call /categories.php endpoint', () async {
        // Arrange
        final mockResponse = FakeResponse(
          data: {'categories': []},
          statusCode: 200,
        );
        when(() => mockDio.get('/categories.php'))
            .thenAnswer((_) async => mockResponse);

        // Act
        final result = await apiService.getCategories();

        // Assert
        expect(result.statusCode, 200);
        verify(() => mockDio.get('/categories.php')).called(1);
      });
    });

    group('getMealDetails', () {
      test('should call /lookup.php?i=<id> endpoint', () async {
        // Arrange
        const mealId = '52772';
        final mockResponse = FakeResponse(
          data: {'meals': []},
          statusCode: 200,
        );
        when(() => mockDio.get('/lookup.php?i=$mealId'))
            .thenAnswer((_) async => mockResponse);

        // Act
        final result = await apiService.getMealDetails(mealId);

        // Assert
        expect(result.statusCode, 200);
        verify(() => mockDio.get('/lookup.php?i=$mealId')).called(1);
      });

      test('should properly format meal ID in URL', () async {
        // Arrange
        const mealId = '12345';
        final mockResponse = FakeResponse(
          data: {'meals': []},
          statusCode: 200,
        );
        when(() => mockDio.get('/lookup.php?i=$mealId'))
            .thenAnswer((_) async => mockResponse);

        // Act
        await apiService.getMealDetails(mealId);

        // Assert
        verify(() => mockDio.get('/lookup.php?i=$mealId')).called(1);
      });
    });

    group('getMealsByCountry', () {
      test('should call /filter.php?a=<country> endpoint', () async {
        // Arrange
        const country = 'Canadian';
        final mockResponse = FakeResponse(
          data: {'meals': []},
          statusCode: 200,
        );
        when(() => mockDio.get('/filter.php?a=$country'))
            .thenAnswer((_) async => mockResponse);

        // Act
        final result = await apiService.getMealsByCountry(country);

        // Assert
        expect(result.statusCode, 200);
        verify(() => mockDio.get('/filter.php?a=$country')).called(1);
      });



    });

    group('searchMeals', () {
      test('should call /search.php?s=<query> endpoint', () async {
        // Arrange
        const query = 'chicken';
        final mockResponse = FakeResponse(
          data: {'meals': []},
          statusCode: 200,
        );
        when(() => mockDio.get('/search.php?s=$query'))
            .thenAnswer((_) async => mockResponse);

        // Act
        final result = await apiService.searchMeals(query);

        // Assert
        expect(result.statusCode, 200);
        verify(() => mockDio.get('/search.php?s=$query')).called(1);
      });

      test('should handle search query with special characters', () async {
        // Arrange
        const query = 'pasta & noodles';
        final mockResponse = FakeResponse(
          data: {'meals': []},
          statusCode: 200,
        );
        when(() => mockDio.get('/search.php?s=$query'))
            .thenAnswer((_) async => mockResponse);

        // Act
        final result = await apiService.searchMeals(query);

        // Assert
        expect(result.statusCode, 200);
        verify(() => mockDio.get('/search.php?s=$query')).called(1);
      });

      test('should handle empty search query', () async {
        // Arrange
        const query = '';
        final mockResponse = FakeResponse(
          data: {'meals': null},
          statusCode: 200,
        );
        when(() => mockDio.get('/search.php?s=$query'))
            .thenAnswer((_) async => mockResponse);

        // Act
        final result = await apiService.searchMeals(query);

        // Assert
        expect(result.statusCode, 200);
        verify(() => mockDio.get('/search.php?s=$query')).called(1);
      });
    });

    group('getCountries', () {
      test('should call /list.php?a=list endpoint', () async {
        // Arrange
        final mockResponse = FakeResponse(
          data: {'meals': []},
          statusCode: 200,
        );
        when(() => mockDio.get('/list.php?a=list'))
            .thenAnswer((_) async => mockResponse);

        // Act
        final result = await apiService.getCountries();

        // Assert
        expect(result.statusCode, 200);
        verify(() => mockDio.get('/list.php?a=list')).called(1);
      });
    });

    group('Error Handling', () {
      test('should handle 404 not found error', () async {
        // Arrange
        when(() => mockDio.get('/random.php')).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/random.php'),
            response: Response(
              requestOptions: RequestOptions(path: '/random.php'),
              statusCode: 404,
            ),
            message: 'Not found',
          ),
        );

        // Act & Assert
        expect(
          () => apiService.getRandomMeals(),
          throwsA(isA<DioException>()),
        );
      });

      test('should handle 500 server error', () async {
        // Arrange
        when(() => mockDio.get('/categories.php')).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/categories.php'),
            response: Response(
              requestOptions: RequestOptions(path: '/categories.php'),
              statusCode: 500,
            ),
            message: 'Internal server error',
          ),
        );

        // Act & Assert
        expect(
          () => apiService.getCategories(),
          throwsA(isA<DioException>()),
        );
      });

      test('should handle timeout error', () async {
        // Arrange
        when(() => mockDio.get('/random.php')).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/random.php'),
            type: DioExceptionType.connectionTimeout,
            message: 'Connection timeout',
          ),
        );

        // Act & Assert
        expect(
          () => apiService.getRandomMeals(),
          throwsA(isA<DioException>()),
        );
      });
    });
  });
}
