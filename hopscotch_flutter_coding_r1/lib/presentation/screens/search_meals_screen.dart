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

    final visibleMeals = state.allMeals.take(state.visibleCount).toList();
    final canLoadMore = state.allMeals.length > state.visibleCount;

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
            else if (state.allMeals.isEmpty)
              const Expanded(
                child: Center(child: Text(AppStrings.noResults)),
              )
            else
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // 2‑column grid
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
                        itemCount: visibleMeals.length,
                        itemBuilder: (context, index) {
                          final meal = visibleMeals[index];
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

                      if (canLoadMore)
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => ref
                                .read(searchMealsNotifierProvider.notifier)
                                .loadMore(),
                            child: const Center(
                             
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    AppStrings.loadMore,
                                    style: TextStyle(
                                      color: Colors.orange, // plain orange
                                    ),
                                  ),
                                  SizedBox(width: 4), // one small space
                                  Icon(
                                    Icons
                                        .keyboard_arrow_down, // bottom arrow icon
                                    size: 18,
                                    color: Colors.orange,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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
