import 'package:flutter_test/flutter_test.dart';
import 'package:hopscotch_flutter_coding_r1/core/constants/app_strings.dart';

void main() {
  group('AppStrings', () {
    group('App Level Strings', () {
      test('appTitle should not be empty', () {
        expect(AppStrings.appTitle, isNotEmpty);
        expect(AppStrings.appTitle, 'Recipe Book');
      });
    });

    group('Home Screen Strings', () {
      test('homeScreenTitle should not be empty', () {
        expect(AppStrings.homeScreenTitle, isNotEmpty);
        expect(AppStrings.homeScreenTitle, 'Recipes');
      });

      test('randomMealsSection should not be empty', () {
        expect(AppStrings.randomMealsSection, isNotEmpty);
        expect(AppStrings.randomMealsSection, 'Random Meals');
      });

      test('noName should not be empty', () {
        expect(AppStrings.noName, isNotEmpty);
        expect(AppStrings.noName, 'No Name');
      });

      test('failedToLoadMeals should contain error context', () {
        expect(AppStrings.failedToLoadMeals, isNotEmpty);
        expect(AppStrings.failedToLoadMeals.contains('load'), true);
      });
    });

    group('Random Meal Card Strings', () {
      test('starItemOfTheDay should not be empty', () {
        expect(AppStrings.starItemOfTheDay, isNotEmpty);
      });

      test('classicRecipe should not be empty', () {
        expect(AppStrings.classicRecipe, isNotEmpty);
      });

      test('deliciousAndEasyToMake should not be empty', () {
        expect(AppStrings.deliciousAndEasyToMake, isNotEmpty);
      });
    });

    group('Category Strings', () {
      test('categorySection should not be empty', () {
        expect(AppStrings.categorySection, isNotEmpty);
        expect(AppStrings.categorySection, 'Category');
      });

      test('failedToLoadCategories should contain error context', () {
        expect(AppStrings.failedToLoadCategories, isNotEmpty);
        expect(AppStrings.failedToLoadCategories.contains('load'), true);
      });
    });

    group('Cuisine Strings', () {
      test('cuisineSection should not be empty', () {
        expect(AppStrings.cuisineSection, isNotEmpty);
        expect(AppStrings.cuisineSection, 'Cuisine');
      });

      test('failedToLoadCuisine should contain error context', () {
        expect(AppStrings.failedToLoadCuisine, isNotEmpty);
        expect(AppStrings.failedToLoadCuisine.contains('load'), true);
      });

      test('navigateToCategorySnackbar should not be empty', () {
        expect(AppStrings.navigateToCategorySnackbar, isNotEmpty);
      });

      test('categoryLabel should not be empty', () {
        expect(AppStrings.categoryLabel, isNotEmpty);
      });
    });

    group('Search Screen Strings', () {
      test('searchMealsTitle should not be empty', () {
        expect(AppStrings.searchMealsTitle, isNotEmpty);
        expect(AppStrings.searchMealsTitle, 'Search Meals');
      });

      test('searchMealsHintText should not be empty', () {
        expect(AppStrings.searchMealsHintText, isNotEmpty);
      });

      test('somethingWentWrong should not be empty', () {
        expect(AppStrings.somethingWentWrong, isNotEmpty);
      });

      test('noResults should not be empty', () {
        expect(AppStrings.noResults, isNotEmpty);
      });

      test('loadMore should not be empty', () {
        expect(AppStrings.loadMore, isNotEmpty);
        expect(AppStrings.loadMore, 'Load more');
      });
    });

    group('Cooking Details Strings', () {
      test('cookingDetailsTitle should not be empty', () {
        expect(AppStrings.cookingDetailsTitle, isNotEmpty);
        expect(AppStrings.cookingDetailsTitle, 'Cooking Details');
      });

      test('failedToLoadDetails should not be empty', () {
        expect(AppStrings.failedToLoadDetails, isNotEmpty);
      });

      test('typeLabel should not be empty', () {
        expect(AppStrings.typeLabel, isNotEmpty);
        expect(AppStrings.typeLabel, 'Type');
      });

      test('cuisineLabel should not be empty', () {
        expect(AppStrings.cuisineLabel, isNotEmpty);
        expect(AppStrings.cuisineLabel, 'Cuisine');
      });

      test('ingredientsSection should not be empty', () {
        expect(AppStrings.ingredientsSection, isNotEmpty);
        expect(AppStrings.ingredientsSection, 'Ingredients');
      });

      test('howToCookSection should not be empty', () {
        expect(AppStrings.howToCookSection, isNotEmpty);
        expect(AppStrings.howToCookSection, 'How to cook');
      });

      test('defaultValue should equal dash', () {
        expect(AppStrings.defaultValue, '-');
      });
    });

    group('API Configuration', () {
      test('baseUrl should be valid TheMealDB API URL', () {
        expect(AppStrings.baseUrl, isNotEmpty);
        expect(AppStrings.baseUrl, 'https://www.themealdb.com/api/json/v1/1');
        expect(AppStrings.baseUrl.startsWith('https://'), true);
      });
    });

    group('String Concatenation Tests', () {
      test('should properly concatenate error messages', () {
        // Act
        final errorMsg = AppStrings.failedToLoadMeals + 'Connection timeout';

        // Assert
        expect(errorMsg, contains('Connection timeout'));
      });

      test('should properly concatenate navigation snackbar', () {
        // Act
        final snackbar = AppStrings.navigateToCategorySnackbar +
            'Seafood' +
            AppStrings.categoryLabel;

        // Assert
        expect(snackbar, contains('Seafood'));
        expect(snackbar.contains('Navigate to'), true);
      });
    });

    group('String Length Validation', () {
      test('all strings should have reasonable length', () {
        // Assert - Check that strings are not excessively long
        expect(AppStrings.appTitle.length, greaterThan(0));
        expect(AppStrings.appTitle.length, lessThan(100));
        expect(AppStrings.cookingDetailsTitle.length, lessThan(100));
      });
    });
  });
}
