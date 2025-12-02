import 'package:flutter_test/flutter_test.dart';
import 'package:hopscotch_flutter_coding_r1/data/models/meal_model.dart';
import 'package:hopscotch_flutter_coding_r1/data/models/meal_details_model.dart';
import 'package:hopscotch_flutter_coding_r1/data/models/category_model.dart';
import '../../fixtures/meal_fixtures.dart';

void main() {
  group('MealModel', () {
    test('should create MealModel from JSON', () {
      // Act
      final model = MealModel.fromJson(MealFixtures.mealModelJson);

      // Assert
      expect(model.id, '52772');
      expect(model.name, 'Teriyaki Chicken Casserole');
      expect(model.imageUrl, isNotEmpty);
      expect(model.instructions, isNotNull);
    });

    test('should convert MealModel to JSON', () {
      // Act
      final json = MealFixtures.mealModel1.toJson();

      // Assert
      expect(json['idMeal'], '52772');
      expect(json['strMeal'], 'Teriyaki Chicken Casserole');
      expect(json['strMealThumb'], isNotEmpty);
    });

    test('should handle missing optional fields', () {
      // Arrange
      final jsonWithoutInstructions = {
        'idMeal': '123',
        'strMeal': 'Test Meal',
        'strMealThumb': 'https://example.com/image.jpg',
      };

      // Act
      final model = MealModel.fromJson(jsonWithoutInstructions);

      // Assert
      expect(model.id, '123');
      expect(model.name, 'Test Meal');
      expect(model.instructions, isNull);
    });
  });

  group('MealResponse', () {
    test('should create MealResponse from JSON with multiple meals', () {
      // Act
      final response = MealResponse.fromJson(MealFixtures.mealResponseJson);

      // Assert
      expect(response.meals, isNotNull);
      expect(response.meals!.length, 2);
      expect(response.meals![0].name, 'Teriyaki Chicken Casserole');
    });

    test('should handle null meals list', () {
      // Arrange
      final json = {'meals': null};

      // Act
      final response = MealResponse.fromJson(json);

      // Assert
      expect(response.meals, isNull);
    });
  });

  group('MealDetailsModel', () {
    test('should create MealDetailsModel from detailed JSON', () {
      // Act
      final model = MealDetailsModel.fromJson(MealFixtures.mealDetailsJson);

      // Assert
      expect(model.idMeal, '52772');
      expect(model.strMeal, 'Teriyaki Chicken Casserole');
      expect(model.strCategory, 'Chicken');
      expect(model.strArea, 'Japanese');
      expect(model.ingredients, isNotEmpty);
      expect(model.measures, isNotEmpty);
    });

    test('should correctly parse ingredients and measures', () {
      // Act
      final model = MealDetailsModel.fromJson(MealFixtures.mealDetailsJson);

      // Assert
      expect(model.ingredients.length, 3);
      expect(model.ingredients[0], 'Chicken');
      expect(model.measures[0], '500g');
    });

    test('should skip empty ingredients', () {
      // Arrange
      final json = {
        'idMeal': '123',
        'strMeal': 'Test',
        'strMealThumb': 'https://example.com/img.jpg',
        'strIngredient1': 'Ingredient1',
        'strIngredient2': '', // Empty ingredient
        'strMeasure1': '100g',
        'strMeasure2': '',
      };

      // Act
      final model = MealDetailsModel.fromJson(json);

      // Assert
      expect(model.ingredients.length, 1);
      expect(model.ingredients[0], 'Ingredient1');
    });

    test('should convert to MealEntity', () {
      // Arrange
      final model = MealDetailsModel.fromJson(MealFixtures.mealDetailsJson);

      // Act
      final entity = model.toEntity();

      // Assert
      expect(entity.id, model.idMeal);
      expect(entity.name, model.strMeal);
      expect(entity.imageUrl, model.strMealThumb);
      expect(entity.category, model.strCategory);
      expect(entity.ingredients, model.ingredients);
    });

    test('should handle missing optional fields in detailed model', () {
      // Arrange
      final json = {
        'idMeal': '123',
        'strMeal': 'Minimal Meal',
        'strMealThumb': 'https://example.com/img.jpg',
      };

      // Act
      final model = MealDetailsModel.fromJson(json);

      // Assert
      expect(model.strCategory, isNull);
      expect(model.strArea, isNull);
      expect(model.ingredients, isEmpty);
    });
  });

  group('CategoryModel', () {
    test('should create CategoryModel from JSON', () {
      // Act
      final model = CategoryModel.fromJson(MealFixtures.categoryJson);

      // Assert
      expect(model.id, '1');
      expect(model.name, 'Seafood');
      expect(model.imageUrl, isNotEmpty);
    });

    test('should verify CategoryModel properties', () {
      // Arrange
      final model = CategoryModel.fromJson(MealFixtures.categoryJson);

      // Assert
      expect(model.id, '1');
      expect(model.name, 'Seafood');
      expect(model.imageUrl, isNotEmpty);
    });
  });

  group('CategoryResponse', () {
    test('should create CategoryResponse from JSON', () {
      // Act
      final response = CategoryResponse.fromJson(MealFixtures.categoriesResponseJson);

      // Assert
      expect(response.categories, isNotNull);
      expect(response.categories.length, 2);
      expect(response.categories[0].name, 'Seafood');
    });
  });

  group('Entity Equality', () {
    test('two MealEntity with same values should be equal', () {
      // Act & Assert
      expect(
        MealFixtures.mealEntity1,
        MealFixtures.mealEntity1,
      );
    });

    test('MealEntity with different IDs should not be equal', () {
      // Act & Assert
      expect(
        MealFixtures.mealEntity1 != MealFixtures.mealEntity2,
        true,
      );
    });
  });
}
