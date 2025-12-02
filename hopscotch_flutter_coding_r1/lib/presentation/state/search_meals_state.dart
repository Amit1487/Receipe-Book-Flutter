import '../../domain/entities/meal.dart';

class SearchMealsState {
  
  final List<MealEntity> categoryList;
  final List<MealEntity> ingredientList;
  final List<MealEntity> cuisineList;
  final int visibleCountCategory;
  final int visibleCountIngredient;
  final int visibleCountCuisine;
  final bool isLoading;
  final Object? error;
  const SearchMealsState({
    this.categoryList = const [],
    this.ingredientList = const [],
    this.cuisineList = const [],
    this.visibleCountCategory = 4,
    this.visibleCountIngredient = 4,
    this.visibleCountCuisine = 4,
    this.isLoading = false,
    this.error,
  });

  SearchMealsState copyWith({
    List<MealEntity>? categoryList,
    List<MealEntity>? ingredientList,
    List<MealEntity>? cuisineList,
    int? visibleCountCategory,
    int? visibleCountIngredient,
    int? visibleCountCuisine,
    bool? isLoading,
    Object? error = _noChange,
  }) {
    return SearchMealsState(
      categoryList: categoryList ?? this.categoryList,
      ingredientList: ingredientList ?? this.ingredientList,
      cuisineList: cuisineList ?? this.cuisineList,
      visibleCountCategory: visibleCountCategory ?? this.visibleCountCategory,
      visibleCountIngredient: visibleCountIngredient ?? this.visibleCountIngredient,
      visibleCountCuisine: visibleCountCuisine ?? this.visibleCountCuisine,
      isLoading: isLoading ?? this.isLoading,
      error: error == _noChange ? this.error : error,
    );
  }
}

const _noChange = Object();