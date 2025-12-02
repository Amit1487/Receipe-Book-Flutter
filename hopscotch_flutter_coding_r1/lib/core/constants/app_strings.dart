/// AppStrings - Centralized string constants for the Recipe Book application
/// 
/// This class contains all hardcoded strings used throughout the app,
/// organized by feature/screen for better maintainability and easier localization.

abstract class AppStrings {
  // ==================== App Level ====================
  static const String appTitle = 'Recipe Book';

  // ==================== Home Screen ====================
  static const String homeScreenTitle = 'Recipes';
  static const String randomMealsSection = 'Random Meals';
  static const String noName = 'No Name';
  static const String failedToLoadMeals = 'Failed to load meals: ';

  // ==================== Random Meal Card ====================
  static const String starItemOfTheDay = 'Star item of the day';
  static const String classicRecipe = 'Classic recipe';
  static const String deliciousAndEasyToMake = 'Delicious and easy to make';

  // ==================== Category Section ====================
  static const String categorySection = 'Category';
  static const String failedToLoadCategories = 'Failed to load categories: ';

  // ==================== Cuisine Section ====================
  static const String cuisineSection = 'Cuisine';
  static const String failedToLoadCuisine = 'Failed to load cuisine: ';
  static const String navigateToCategorySnackbar = 'Navigate to ';
  static const String categoryLabel = ' category';

  // ==================== Search Screen ====================
  static const String searchMealsTitle = 'Search Meals';
  static const String searchMealsHintText = 'Search meals';
  static const String somethingWentWrong = 'Something went wrong';
  static const String noResults = 'No results';
  static const String loadMore = 'Load more';

  // ==================== Cooking Details Screen ====================
  static const String cookingDetailsTitle = 'Cooking Details';
  static const String failedToLoadDetails = 'Failed to load details';
  static const String typeLabel = 'Type';
  static const String cuisineLabel = 'Cuisine';
  static const String ingredientsSection = 'Ingredients';
  static const String howToCookSection = 'How to cook';
  static const String defaultValue = '-';

  // ==================== API Configuration ====================
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1';
}
