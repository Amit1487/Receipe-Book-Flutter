import 'package:json_annotation/json_annotation.dart';
part 'category_model.g.dart';

@JsonSerializable()
class CategoryResponse {
  final List<CategoryModel> categories;
  
  CategoryResponse({required this.categories});
  
  factory CategoryResponse.fromJson(Map<String, dynamic> json) => 
      _$CategoryResponseFromJson(json);
}

@JsonSerializable()
class CategoryModel {
  @JsonKey(name: 'idCategory')
  final String id;
  
  @JsonKey(name: 'strCategory')
  final String name;
  
  @JsonKey(name: 'strCategoryThumb')
  final String imageUrl;

  CategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => 
      _$CategoryModelFromJson(json);
}
