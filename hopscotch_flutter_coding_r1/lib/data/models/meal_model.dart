import 'package:json_annotation/json_annotation.dart';
part 'meal_model.g.dart';

@JsonSerializable()
class MealResponse {
  final List<MealModel>? meals;
  MealResponse({this.meals});
  factory MealResponse.fromJson(Map<String, dynamic> json) => _$MealResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MealResponseToJson(this);
}

@JsonSerializable()
class MealModel {
  @JsonKey(name: 'idMeal')
  final String id;
  @JsonKey(name: 'strMeal')
  final String name;
  @JsonKey(name: 'strMealThumb')
  final String imageUrl;
  @JsonKey(name: 'strInstructions')
  final String? instructions;

  MealModel({required this.id, required this.name, required this.imageUrl, this.instructions});

  factory MealModel.fromJson(Map<String, dynamic> json) => _$MealModelFromJson(json);
  Map<String, dynamic> toJson() => _$MealModelToJson(this);
}
