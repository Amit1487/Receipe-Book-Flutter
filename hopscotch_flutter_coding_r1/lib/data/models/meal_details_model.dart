

import 'package:hopscotch_flutter_coding_r1/domain/entities/meal.dart';

class MealDetailsModel {
  final String idMeal;
  final String strMeal;
  final String? strCategory;
  final String? strArea;
  final String? strInstructions;
  final String strMealThumb;
  final List<String> ingredients;
  final List<String> measures;

  MealDetailsModel({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
    this.strCategory,
    this.strArea,
    this.strInstructions,
    required this.ingredients,
    required this.measures,
  });

  factory MealDetailsModel.fromJson(Map<String, dynamic> json) {
    final ingredients = <String>[];
    final measures = <String>[];

    // Parse strIngredient1..20 + strMeasure1..20 exactly as in sample
    for (int i = 1; i <= 20; i++) {
      final ing = (json['strIngredient$i'] as String?)?.trim();
      final meas = (json['strMeasure$i'] as String?)?.trim();

      final hasIngredient = ing != null && ing.isNotEmpty;
      if (hasIngredient) {
        ingredients.add(ing);
        measures.add(meas != null && meas.isNotEmpty ? meas : '');
      }
    }

    return MealDetailsModel(
      idMeal: json['idMeal'] as String,
      strMeal: json['strMeal'] as String,
      strMealThumb: json['strMealThumb'] as String,
      strCategory: json['strCategory'] as String?,
      strArea: json['strArea'] as String?,
      strInstructions: json['strInstructions'] as String?,
      ingredients: ingredients,
      measures: measures,
    );
  }

  MealEntity toEntity() {
    return MealEntity(
      id: idMeal,
      name: strMeal,
      imageUrl: strMealThumb,
      category: strCategory,
      area: strArea,
      instructions: strInstructions,
      ingredients: ingredients,
      measures: measures,
    );
  }
}
