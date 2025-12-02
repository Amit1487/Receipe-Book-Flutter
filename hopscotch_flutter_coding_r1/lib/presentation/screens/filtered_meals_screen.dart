import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hopscotch_flutter_coding_r1/core/constants/app_strings.dart';
import 'package:hopscotch_flutter_coding_r1/core/di/providers.dart';
import 'package:hopscotch_flutter_coding_r1/presentation/widgets/meal_grid_item.dart';
import 'package:hopscotch_flutter_coding_r1/presentation/screens/cooking_details_screen.dart';
import 'package:hopscotch_flutter_coding_r1/domain/entities/meal.dart';

enum FilterType { category, ingredient, cuisine }

class FilteredMealsScreen extends ConsumerStatefulWidget {
  final String query;
  final FilterType filterType;
  final String? title;

  const FilteredMealsScreen({
    super.key,
    required this.query,
    required this.filterType,
    this.title,
  });

  @override
  ConsumerState<FilteredMealsScreen> createState() =>
      _FilteredMealsScreenState();
}

class _FilteredMealsScreenState extends ConsumerState<FilteredMealsScreen> {
  List<MealEntity> _meals = [];
  bool _isLoading = false;
  Object? _error;
  int _visibleCount = 4; // 2 columns x 2 rows

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  Future<void> _fetch() async {
    setState(() {
      _isLoading = true;
      _error = null;
      _visibleCount = 4;
    });

    try {
      final repo = ref.read(mealRepositoryProvider);
      late final List<MealEntity> results;
      switch (widget.filterType) {
        case FilterType.category:
          results = await repo.getMealsByCategory(widget.query);
          break;
        case FilterType.ingredient:
          results = await repo.getMealsByIngredient(widget.query);
          break;
        case FilterType.cuisine:
          results = await repo.getMealsByCountry(widget.query);
          break;
      }

      setState(() {
        _meals = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e;
        _isLoading = false;
      });
    }
  }

  void _loadMore() {
    final current = _visibleCount;
    final total = _meals.length;
    if (current >= total) return;
    final next = (current + 4) > total ? total : current + 4;
    setState(() {
      _visibleCount = next;
    });
  }

  @override
  Widget build(BuildContext context) {
    final visible = _meals.take(_visibleCount).toList();
    final canLoadMore = _meals.length > _visibleCount;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? widget.query),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Text(
                    AppStrings.somethingWentWrong,
                    style: TextStyle(color: Colors.red[700]),
                  ),
                )
              : _meals.isEmpty
                  ? const Center(child: Text(AppStrings.noResults))
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
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
                            itemCount: visible.length,
                            itemBuilder: (context, index) {
                              final meal = visible[index];
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
                                onPressed: _loadMore,
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
                        ],
                      ),
                    ),
    );
  }
}
