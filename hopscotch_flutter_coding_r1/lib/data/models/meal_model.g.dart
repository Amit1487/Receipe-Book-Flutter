// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealResponse _$MealResponseFromJson(Map<String, dynamic> json) => MealResponse(
      meals: (json['meals'] as List<dynamic>?)
          ?.map((e) => MealModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MealResponseToJson(MealResponse instance) =>
    <String, dynamic>{
      'meals': instance.meals,
    };

MealModel _$MealModelFromJson(Map<String, dynamic> json) => MealModel(
      id: json['idMeal'] as String,
      name: json['strMeal'] as String,
      imageUrl: json['strMealThumb'] as String,
      instructions: json['strInstructions'] as String?,
    );

Map<String, dynamic> _$MealModelToJson(MealModel instance) => <String, dynamic>{
      'idMeal': instance.id,
      'strMeal': instance.name,
      'strMealThumb': instance.imageUrl,
      'strInstructions': instance.instructions,
    };
