import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/cousine.dart';
part 'cousine_model.g.dart';

@JsonSerializable()
class CousineResponse {
  final List<CuisineMealModel> meals;

  CousineResponse({required this.meals});

  factory CousineResponse.fromJson(Map<String, dynamic> json) => 
      _$CousineResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CousineResponseToJson(this);
}

@JsonSerializable()
class CuisineMealModel {
  @JsonKey(name: 'idMeal')
  final String id;
  
  @JsonKey(name: 'strMeal')
  final String name;
  
  @JsonKey(name: 'strMealThumb')
  final String imageUrl;

  CuisineMealModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  // Convert to Domain Entity
  CousinEntity toEntity() => CousinEntity(
    id: id,
    name: name,
    imageUrl: imageUrl,
  );

  factory CuisineMealModel.fromJson(Map<String, dynamic> json) => 
      _$CuisineMealModelFromJson(json);
  Map<String, dynamic> toJson() => _$CuisineMealModelToJson(this);
}
