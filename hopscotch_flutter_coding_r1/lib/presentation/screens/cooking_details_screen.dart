import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hopscotch_flutter_coding_r1/core/constants/app_strings.dart';
import 'package:hopscotch_flutter_coding_r1/presentation/screens/filtered_meals_screen.dart';

import '../providers/home_provider.dart';
import '../../domain/entities/meal.dart';

class CookingDetailsScreen extends ConsumerWidget {
  final String mealId;

  const CookingDetailsScreen({
    Key? key,
    required this.mealId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsAsync = ref.watch(mealDetailsProvider(mealId));

    return detailsAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        appBar: AppBar(title: const Text(AppStrings.cookingDetailsTitle)),
        body: const Center(child: Text(AppStrings.failedToLoadDetails)),
      ),
      data: (meals) {
        if (meals.isEmpty) {
          // blank screen
          return const SizedBox.shrink();
        }
        final meal = meals[0];
        return _CookingDetailsContent(meal: meal);
      },
    );
  }
}

class _CookingDetailsContent extends StatelessWidget {
  final MealEntity meal;

  const _CookingDetailsContent({Key? key, required this.meal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ingredients = meal.ingredients;
    final measures = meal.measures;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.cookingDetailsTitle),
        centerTitle: false,
        backgroundColor: Colors.purple[200],
        foregroundColor: Colors.white,
        elevation: 1,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header image
            SizedBox(
              width: double.infinity,
              height: 220,
              child: CachedNetworkImage(
                imageUrl: meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Center(
                    child: Text(
                      meal.name,
                      textAlign: TextAlign.center,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Type & Cuisine row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _LabelValueColumn(
                        label: AppStrings.typeLabel,
                        value: meal.category ?? AppStrings.defaultValue,
                      ),
                      _LabelValueColumn(
                        label: AppStrings.cuisineLabel,
                        value: meal.area ?? AppStrings.defaultValue,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Ingredients title
                  Text(
                    AppStrings.ingredientsSection,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 12),

                  // Ingredients grid (icon + text style)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: ingredients.length,
                    itemBuilder: (context, index) {
                      final name = ingredients[index];
                      final measure =
                          index < measures.length ? measures[index] : '';
                      return _IngredientItem(
                        name: name,
                        measure: measure,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FilteredMealsScreen(
                                query: name,
                                filterType: FilterType.ingredient,
                                title: name,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  // How to cook
                  Text(
                    AppStrings.howToCookSection,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    meal.instructions ?? '',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          height: 1.4,
                        ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LabelValueColumn extends StatelessWidget {
  final String label;
  final String value;

  const _LabelValueColumn({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _IngredientItem extends StatelessWidget {
  final String name;
  final String measure;
  final VoidCallback? onTap;

  const _IngredientItem({
    Key? key,
    required this.name,
    required this.measure,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          // Placeholder circle for ingredient icon (you can later change to real images)
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orange[50],
            ),
            child: const Icon(Icons.restaurant, color: Colors.orange),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
          ),
          if (measure.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(
              measure,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ],
      ),
    );
  }
}
