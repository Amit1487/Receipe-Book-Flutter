import 'package:hopscotch_flutter_coding_r1/domain/entities/meal.dart';
import 'package:hopscotch_flutter_coding_r1/domain/entities/category.dart';
import 'package:hopscotch_flutter_coding_r1/domain/entities/cousine.dart';
import 'package:hopscotch_flutter_coding_r1/data/models/meal_model.dart';
// Removed unused model imports

/// Test fixtures for meal-related entities and models
class MealFixtures {
  /// Sample meal entity for testing
  static const MealEntity mealEntity1 = MealEntity(
    id: '52772',
    name: 'Teriyaki Chicken Casserole',
    imageUrl: 'https://www.themealdb.com/images/media/meals/1234567890.jpg',
    category: 'Chicken',
    area: 'Japanese',
    instructions: 'Mix all ingredients and bake for 30 minutes',
    ingredients: ['Chicken', 'Soy Sauce', 'Ginger'],
    measures: ['500g', '100ml', '10g'],
  );

  static const MealEntity mealEntity2 = MealEntity(
    id: '52775',
    name: 'Fish and Chips',
    imageUrl: 'https://www.themealdb.com/images/media/meals/0987654321.jpg',
    category: 'Fish',
    area: 'British',
    instructions: 'Batter and deep fry the fish',
    ingredients: ['Cod', 'Potatoes', 'Flour'],
    measures: ['400g', '600g', '200g'],
  );

  static const MealEntity mealEntity3 = MealEntity(
    id: '52778',
    name: 'Pasta Carbonara',
    imageUrl: 'https://www.themealdb.com/images/media/meals/1111111111.jpg',
    category: 'Pasta',
    area: 'Italian',
    instructions: 'Cook pasta, mix with egg and cheese',
    ingredients: ['Spaghetti', 'Eggs', 'Bacon', 'Parmesan'],
    measures: ['400g', '4', '200g', '100g'],
  );

  static final List<MealEntity> mealEntities = [
    mealEntity1,
    mealEntity2,
    mealEntity3,
  ];

  /// Sample meal model for JSON testing
  static final MealModel mealModel1 = MealModel(
    id: '52772',
    name: 'Teriyaki Chicken Casserole',
    imageUrl: 'https://www.themealdb.com/images/media/meals/1234567890.jpg',
    instructions: 'Mix all ingredients and bake for 30 minutes',
  );

  static final Map<String, dynamic> mealModelJson = {
    'idMeal': '52772',
    'strMeal': 'Teriyaki Chicken Casserole',
    'strMealThumb': 'https://www.themealdb.com/images/media/meals/1234567890.jpg',
    'strInstructions': 'Mix all ingredients and bake for 30 minutes',
  };

  /// Sample meal response JSON
  static final Map<String, dynamic> mealResponseJson = {
    'meals': [
      {
        'idMeal': '52772',
        'strMeal': 'Teriyaki Chicken Casserole',
        'strMealThumb': 'https://www.themealdb.com/images/media/meals/1234567890.jpg',
        'strInstructions': 'Mix all ingredients and bake for 30 minutes',
      },
      {
        'idMeal': '52775',
        'strMeal': 'Fish and Chips',
        'strMealThumb': 'https://www.themealdb.com/images/media/meals/0987654321.jpg',
        'strInstructions': 'Batter and deep fry the fish',
      },
    ]
  };

  /// Sample meal details JSON with ingredients
  static final Map<String, dynamic> mealDetailsJson = {
    'idMeal': '52772',
    'strMeal': 'Teriyaki Chicken Casserole',
    'strMealThumb': 'https://www.themealdb.com/images/media/meals/1234567890.jpg',
    'strCategory': 'Chicken',
    'strArea': 'Japanese',
    'strInstructions': 'Mix all ingredients and bake for 30 minutes',
    'strIngredient1': 'Chicken',
    'strIngredient2': 'Soy Sauce',
    'strIngredient3': 'Ginger',
    'strMeasure1': '500g',
    'strMeasure2': '100ml',
    'strMeasure3': '10g',
  };

  /// Sample category entity
  static const CategoryEntity categoryEntity1 = CategoryEntity(
    id: '1',
    name: 'Seafood',
    imageUrl: 'https://www.themealdb.com/images/category/seafood.png',
  );

  static const CategoryEntity categoryEntity2 = CategoryEntity(
    id: '2',
    name: 'Chicken',
    imageUrl: 'https://www.themealdb.com/images/category/chicken.png',
  );

  static final List<CategoryEntity> categoryEntities = [
    categoryEntity1,
    categoryEntity2,
  ];

  static final Map<String, dynamic> categoryJson = {
    'idCategory': '1',
    'strCategory': 'Seafood',
    'strCategoryThumb': 'https://www.themealdb.com/images/category/seafood.png',
  };

  static final Map<String, dynamic> categoriesResponseJson = {
    'categories': [
      {
        'idCategory': '1',
        'strCategory': 'Seafood',
        'strCategoryThumb': 'https://www.themealdb.com/images/category/seafood.png',
      },
      {
        'idCategory': '2',
        'strCategory': 'Chicken',
        'strCategoryThumb': 'https://www.themealdb.com/images/category/chicken.png',
      },
    ]
  };

  /// Sample cuisine entity
  static const CousinEntity cousineEntity1 = CousinEntity(
    id: '1',
    name: 'Japanese',
    imageUrl: 'https://www.themealdb.com/images/cuisine/japanese.png',
  );

  static const CousinEntity cousineEntity2 = CousinEntity(
    id: '2',
    name: 'Italian',
    imageUrl: 'https://www.themealdb.com/images/cuisine/italian.png',
  );

  static final List<CousinEntity> cousineEntities = [
    cousineEntity1,
    cousineEntity2,
  ];
}
