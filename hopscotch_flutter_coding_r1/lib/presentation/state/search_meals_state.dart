import '../../domain/entities/meal.dart';

class SearchMealsState {
  final List<MealEntity> allMeals;
  final int visibleCount;
  final bool isLoading;
  final Object? error;

  const SearchMealsState({
    this.allMeals = const [],
    this.visibleCount = 4,
    this.isLoading = false,
    this.error,
  });

  SearchMealsState copyWith({
    List<MealEntity>? allMeals,
    int? visibleCount,
    bool? isLoading,
    Object? error = _noChange,
  }) {
    return SearchMealsState(
      allMeals: allMeals ?? this.allMeals,
      visibleCount: visibleCount ?? this.visibleCount,
      isLoading: isLoading ?? this.isLoading,
      error: error == _noChange ? this.error : error,
    );
  }
}

const _noChange = Object();