import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hopscotch_flutter_coding_r1/core/constants/app_strings.dart';
import '../../domain/entities/category.dart';
import '../providers/home_provider.dart';
import '../screens/search_meals_screen.dart';

class CategoryCarousel extends ConsumerStatefulWidget {
  const CategoryCarousel({Key? key}) : super(key: key);

  @override
  ConsumerState<CategoryCarousel> createState() => _CategoryCarouselState();
}

class _CategoryCarouselState extends ConsumerState<CategoryCarousel> {
  int currentCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return categoriesAsync.when(
      data: (categories) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            AppStrings.categorySection,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
          ),
          const SizedBox(height: 16),

          // 3x3 Grid that scrolls horizontally
          SizedBox(
            height: 350, // Fixed height for 3 rows
            child: CarouselSlider.builder(
              itemCount: (categories.length / 9).ceil(), // Pages for 3x3 grid
              itemBuilder: (context, pageIndex, _) {
                final startIndex = pageIndex * 9;

                return GridView.count(
                  crossAxisCount: 4, // 3 columns
                  crossAxisSpacing: 12, // Horizontal spacing
                  mainAxisSpacing: 15, // Vertical spacing
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(), // Disable grid scroll
                  children: List.generate(9, (gridIndex) {
                    final categoryIndex = startIndex + gridIndex;
                    if (categoryIndex < categories.length) {
                      return CategoryItem(
                        category: categories[categoryIndex],
                        onTap: () => _navigateToCategory(
                            context, categories[categoryIndex].id),
                      );
                    } else {
                      return const SizedBox(); // Empty grid slot
                    }
                  }),
                );
              },
              options: CarouselOptions(
                height: 350,
                viewportFraction: 1.0, // Full width pages
                enableInfiniteScroll: true,
                autoPlay: false,
                scrollPhysics: const BouncingScrollPhysics(),
                onPageChanged: (index, reason) {
                  setState(() {
                    currentCategoryIndex = index;
                  });
                },
              ),
            ),
          ),

          // const SizedBox(height: 16),
          // Progress dots for grid pages
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: List.generate(
          //     (categories.length / 9).ceil(),
          //     (index) => _buildCategoryDot(context, index),
          //   ),
          // ),
        ],
      ),
      loading: () => const SizedBox(
        height: 120,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFB71C1C)),
            strokeWidth: 3,
          ),
        ),
      ),
      error: (error, stack) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          AppStrings.failedToLoadCategories + error.toString(),
          style: TextStyle(color: Colors.red[700]),
        ),
      ),
    );
  }

  // Widget _buildCategoryDot(BuildContext context, int index) {
  //   return AnimatedContainer(
  //     duration: const Duration(milliseconds: 300),
  //     margin: const EdgeInsets.symmetric(horizontal: 4),
  //     width: currentCategoryIndex == index ? 24 : 8,
  //     height: 8,
  //     decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       color: currentCategoryIndex == index
  //           ? const Color(0xFFB71C1C) // Dark red active
  //           : Colors.grey[400]!,
  //       boxShadow: currentCategoryIndex == index
  //           ? [
  //               BoxShadow(
  //                 color: const Color(0xFFB71C1C).withOpacity(0.4),
  //                 blurRadius: 8,
  //                 spreadRadius: 2,
  //               )
  //             ]
  //           : null,
  //     ),
  //   );
  // }

  void _navigateToCategory(BuildContext context, String categoryId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppStrings.navigateToCategorySnackbar + categoryId + AppStrings.categoryLabel)),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const SearchMealsScreen(),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final CategoryEntity category;
  final VoidCallback onTap;

  const CategoryItem({
    Key? key,
    required this.category,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Category Image (fixed size for grid)
          Expanded(
            flex: 3,
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: category.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xFFB71C1C)),
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[200],
                  child: const Icon(
                    Icons.category_outlined,
                    color: Color(0xFF757575),
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
          // Category Name
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8.0, top: 8.0, bottom: 0.0),
              child: Text(
                category.name,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF212121),
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
