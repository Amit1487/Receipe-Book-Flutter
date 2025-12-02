import 'package:flutter_test/flutter_test.dart';
import 'package:hopscotch_flutter_coding_r1/domain/entities/meal.dart';
import 'package:hopscotch_flutter_coding_r1/domain/entities/category.dart';
import 'package:hopscotch_flutter_coding_r1/domain/entities/cousine.dart';

void main() {
  group('MealEntity', () {
    test('should create MealEntity with all parameters', () {
      // Act
      const meal = MealEntity(
        id: '1',
        name: 'Test Meal',
        imageUrl: 'https://example.com/image.jpg',
        category: 'Italian',
        area: 'Italy',
        instructions: 'Mix and cook',
        ingredients: ['Pasta', 'Tomato'],
        measures: ['400g', '500g'],
      );

      // Assert
      expect(meal.id, '1');
      expect(meal.name, 'Test Meal');
      expect(meal.imageUrl, 'https://example.com/image.jpg');
      expect(meal.category, 'Italian');
      expect(meal.area, 'Italy');
      expect(meal.instructions, 'Mix and cook');
      expect(meal.ingredients.length, 2);
      expect(meal.measures.length, 2);
    });

    test('should create MealEntity with optional parameters as null', () {
      // Act
      const meal = MealEntity(
        id: '1',
        name: 'Test Meal',
        imageUrl: 'https://example.com/image.jpg',
      );

      // Assert
      expect(meal.id, '1');
      expect(meal.name, 'Test Meal');
      expect(meal.category, isNull);
      expect(meal.area, isNull);
      expect(meal.instructions, isNull);
      expect(meal.ingredients, isEmpty);
      expect(meal.measures, isEmpty);
    });

    test('should create MealEntity with default empty lists', () {
      // Act
      const meal = MealEntity(
        id: '1',
        name: 'Test Meal',
        imageUrl: 'https://example.com/image.jpg',
      );

      // Assert
      expect(meal.ingredients, isA<List<String>>());
      expect(meal.measures, isA<List<String>>());
    });

    test('MealEntity with same values should be equal', () {
      // Act
      const meal1 = MealEntity(
        id: '1',
        name: 'Test Meal',
        imageUrl: 'https://example.com/image.jpg',
      );
      const meal2 = MealEntity(
        id: '1',
        name: 'Test Meal',
        imageUrl: 'https://example.com/image.jpg',
      );

      // Assert
      expect(meal1, meal2);
    });

    test('MealEntity with different IDs should not be equal', () {
      // Act
      const meal1 = MealEntity(
        id: '1',
        name: 'Test Meal',
        imageUrl: 'https://example.com/image.jpg',
      );
      const meal2 = MealEntity(
        id: '2',
        name: 'Test Meal',
        imageUrl: 'https://example.com/image.jpg',
      );

      // Assert
      expect(meal1, isNot(meal2));
    });

    test('should handle empty ingredients list', () {
      // Act
      const meal = MealEntity(
        id: '1',
        name: 'Test Meal',
        imageUrl: 'https://example.com/image.jpg',
        ingredients: [],
      );

      // Assert
      expect(meal.ingredients, isEmpty);
    });

    test('should handle long ingredient list', () {
      // Arrange
      final ingredients = List.generate(20, (i) => 'Ingredient $i');

      // Act
      final meal = MealEntity(
        id: '1',
        name: 'Complex Meal',
        imageUrl: 'https://example.com/image.jpg',
        ingredients: ingredients,
      );

      // Assert
      expect(meal.ingredients.length, 20);
    });
  });

  group('CategoryEntity', () {
    test('should create CategoryEntity with all parameters', () {
      // Act
      const category = CategoryEntity(
        id: '1',
        name: 'Seafood',
        imageUrl: 'https://example.com/seafood.jpg',
      );

      // Assert
      expect(category.id, '1');
      expect(category.name, 'Seafood');
      expect(category.imageUrl, 'https://example.com/seafood.jpg');
    });

    test('CategoryEntity with same values should be equal', () {
      // Act
      const category1 = CategoryEntity(
        id: '1',
        name: 'Seafood',
        imageUrl: 'https://example.com/seafood.jpg',
      );
      const category2 = CategoryEntity(
        id: '1',
        name: 'Seafood',
        imageUrl: 'https://example.com/seafood.jpg',
      );

      // Assert
      expect(category1, category2);
    });

    test('CategoryEntity with different IDs should not be equal', () {
      // Act
      const category1 = CategoryEntity(
        id: '1',
        name: 'Seafood',
        imageUrl: 'https://example.com/seafood.jpg',
      );
      const category2 = CategoryEntity(
        id: '2',
        name: 'Seafood',
        imageUrl: 'https://example.com/seafood.jpg',
      );

      // Assert
      expect(category1, isNot(category2));
    });

    test('should handle special characters in category name', () {
      // Act
      const category = CategoryEntity(
        id: '1',
        name: 'Desserts & Bakes',
        imageUrl: 'https://example.com/dessert.jpg',
      );

      // Assert
      expect(category.name, 'Desserts & Bakes');
    });
  });

  group('CousinEntity', () {
    test('should create CousinEntity with all parameters', () {
      // Act
      const cousin = CousinEntity(
        id: '1',
        name: 'Italian',
        imageUrl: 'https://example.com/italian.jpg',
      );

      // Assert
      expect(cousin.id, '1');
      expect(cousin.name, 'Italian');
      expect(cousin.imageUrl, 'https://example.com/italian.jpg');
    });

    test('CousinEntity with same values should be equal', () {
      // Act
      const cousin1 = CousinEntity(
        id: '1',
        name: 'Italian',
        imageUrl: 'https://example.com/italian.jpg',
      );
      const cousin2 = CousinEntity(
        id: '1',
        name: 'Italian',
        imageUrl: 'https://example.com/italian.jpg',
      );

      // Assert
      expect(cousin1, cousin2);
    });

    test('CousinEntity with different IDs should not be equal', () {
      // Act
      const cousin1 = CousinEntity(
        id: '1',
        name: 'Italian',
        imageUrl: 'https://example.com/italian.jpg',
      );
      const cousin2 = CousinEntity(
        id: '2',
        name: 'Italian',
        imageUrl: 'https://example.com/italian.jpg',
      );

      // Assert
      expect(cousin1, isNot(cousin2));
    });

    test('should handle different country names', () {
      // Act
      const cousin1 = CousinEntity(
        id: '1',
        name: 'American',
        imageUrl: 'https://example.com/american.jpg',
      );
      const cousin2 = CousinEntity(
        id: '2',
        name: 'Mexican',
        imageUrl: 'https://example.com/mexican.jpg',
      );
      const cousin3 = CousinEntity(
        id: '3',
        name: 'Thai',
        imageUrl: 'https://example.com/thai.jpg',
      );

      // Assert
      expect(cousin1 != cousin2, true);
      expect(cousin2 != cousin3, true);
    });
  });

  group('Entity Hashcode', () {
    test('MealEntity with same values should have same hashcode', () {
      // Act
      const meal1 = MealEntity(
        id: '1',
        name: 'Test',
        imageUrl: 'https://example.com/image.jpg',
      );
      const meal2 = MealEntity(
        id: '1',
        name: 'Test',
        imageUrl: 'https://example.com/image.jpg',
      );

      // Assert
      expect(meal1.hashCode, meal2.hashCode);
    });

    test('CategoryEntity with same values should have same hashcode', () {
      // Act
      const category1 = CategoryEntity(
        id: '1',
        name: 'Seafood',
        imageUrl: 'https://example.com/seafood.jpg',
      );
      const category2 = CategoryEntity(
        id: '1',
        name: 'Seafood',
        imageUrl: 'https://example.com/seafood.jpg',
      );

      // Assert
      expect(category1.hashCode, category2.hashCode);
    });
  });
}
