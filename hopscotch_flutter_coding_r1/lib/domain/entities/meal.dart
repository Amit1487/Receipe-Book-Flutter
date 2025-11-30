class MealEntity {
  final String id;
  final String name;
   final String? category;      // e.g. "Chicken"
  final String? area;          // e.g. "Japanese"
  final String imageUrl;
  final String? instructions;
    final List<String> ingredients;
  final List<String> measures;

  const MealEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.category,
    this.area,
    this.instructions,
    this.ingredients = const [],
    this.measures = const [],
  });
}
