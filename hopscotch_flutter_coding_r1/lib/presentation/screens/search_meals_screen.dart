// lib/presentation/screens/search_meals_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hopscotch_flutter_coding_r1/core/constants/app_strings.dart';
import '../providers/search_meals_provider.dart';
import '../widgets/meal_grid_item.dart';
import 'cooking_details_screen.dart';

class SearchMealsScreen extends ConsumerStatefulWidget {
  const SearchMealsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchMealsScreen> createState() => _SearchMealsScreenState();
}

class _SearchMealsScreenState extends ConsumerState<SearchMealsScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSearch() {
    final query = _controller.text.trim();
    if (query.isEmpty) return;
    ref.read(searchMealsNotifierProvider.notifier).search(query);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchMealsNotifierProvider);

    final visibleCategory =
        state.categoryList.take(state.visibleCountCategory).toList();
    final canLoadMoreCategory =
        state.categoryList.length > state.visibleCountCategory;

    final visibleIngredient =
        state.ingredientList.take(state.visibleCountIngredient).toList();
    final canLoadMoreIngredient =
        state.ingredientList.length > state.visibleCountIngredient;

    final visibleCuisine =
        state.cuisineList.take(state.visibleCountCuisine).toList();
    final canLoadMoreCuisine =
        state.cuisineList.length > state.visibleCountCuisine;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.searchMealsTitle,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search bar
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: AppStrings.searchMealsHintText,
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    onSubmitted: (_) => _onSearch(),
                  ),
                ),
                // const SizedBox(width: 8),
                // ElevatedButton(
                //   onPressed: _onSearch,
                //   child: const Text('Search'),
                // ),
              ],
            ),
            const SizedBox(height: 16),

            if (state.isLoading)
                      const Expanded(
                        child: Center(child: CircularProgressIndicator()),
                      )
                    else if (state.error != null)
                      Expanded(
                        child: Center(
                          child: Text(
                            AppStrings.somethingWentWrong,
                            style: TextStyle(color: Colors.red[700]),
                          ),
                        ),
                      )
                    else if (state.categoryList.isEmpty && state.ingredientList.isEmpty && state.cuisineList.isEmpty)
                      const Expanded(
                        child: Center(child: Text(AppStrings.noResults)),
                      )
                    else
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                      // Category section
                      if (state.categoryList.isNotEmpty) ...[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppStrings.categorySection,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        const SizedBox(height: 12),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: visibleCategory.length,
                          itemBuilder: (context, index) {
                            final meal = visibleCategory[index];
                            return MealGridItem(
                              meal: meal,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        CookingDetailsScreen(mealId: meal.id),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        if (canLoadMoreCategory)
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () => ref
                                  .read(searchMealsNotifierProvider.notifier)
                                  .loadMoreCategory(),
                              child: const Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      AppStrings.loadMore,
                                      style: TextStyle(
                                        color: Colors.orange,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 18,
                                      color: Colors.orange,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 20),
                      ],

                      // Ingredient section
                      if (state.ingredientList.isNotEmpty) ...[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Ingredients',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        const SizedBox(height: 12),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: visibleIngredient.length,
                          itemBuilder: (context, index) {
                            final meal = visibleIngredient[index];
                            return MealGridItem(
                              meal: meal,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        CookingDetailsScreen(mealId: meal.id),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        if (canLoadMoreIngredient)
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () => ref
                                  .read(searchMealsNotifierProvider.notifier)
                                  .loadMoreIngredient(),
                              child: const Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      AppStrings.loadMore,
                                      style: TextStyle(
                                        color: Colors.orange,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 18,
                                      color: Colors.orange,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 20),
                      ],

                      // Cuisine section
                      if (state.cuisineList.isNotEmpty) ...[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppStrings.cuisineSection,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        const SizedBox(height: 12),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: visibleCuisine.length,
                          itemBuilder: (context, index) {
                            final meal = visibleCuisine[index];
                            return MealGridItem(
                              meal: meal,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        CookingDetailsScreen(mealId: meal.id),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        if (canLoadMoreCuisine)
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () => ref
                                  .read(searchMealsNotifierProvider.notifier)
                                  .loadMoreCuisine(),
                              child: const Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      AppStrings.loadMore,
                                      style: TextStyle(
                                        color: Colors.orange,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 18,
                                      color: Colors.orange,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 20),
                      ],
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
