// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cousine_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CousineResponse _$CousineResponseFromJson(Map<String, dynamic> json) =>
    CousineResponse(
      meals: (json['meals'] as List<dynamic>)
          .map((e) => CuisineMealModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CousineResponseToJson(CousineResponse instance) =>
    <String, dynamic>{
      'meals': instance.meals,
    };

CuisineMealModel _$CuisineMealModelFromJson(Map<String, dynamic> json) =>
    CuisineMealModel(
      id: json['idMeal'] as String,
      name: json['strMeal'] as String,
      imageUrl: json['strMealThumb'] as String,
    );

Map<String, dynamic> _$CuisineMealModelToJson(CuisineMealModel instance) =>
    <String, dynamic>{
      'idMeal': instance.id,
      'strMeal': instance.name,
      'strMealThumb': instance.imageUrl,
    };
