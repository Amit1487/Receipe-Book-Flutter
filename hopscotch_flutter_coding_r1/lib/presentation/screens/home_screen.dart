import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hopscotch_flutter_coding_r1/presentation/widgets/cuisine_grid.dart';
import 'package:hopscotch_flutter_coding_r1/core/constants/app_strings.dart';
import '../providers/home_provider.dart';
import '../widgets/category_carousel.dart';
import 'cooking_details_screen.dart';
import '../widgets/random_meal_card.dart';
import 'dart:math';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final randomMealsAsync = ref.watch(randomMealsProvider);
    final random = Random();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.homeScreenTitle,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.randomMealsSection,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 16),
              randomMealsAsync.when(
                data: (meals) => Column(
                  children: [
                    // Random Meals Carousel
                    CarouselSlider.builder(
                      itemCount: 6,
                      itemBuilder: (context, index, _) {
                        final meal = meals[index % meals.length];
                        return GestureDetector(
                          onTap: () => _navigateToDetails(context, meal.id),
                          child: Column(
                            children: [
                              // Replace the entire ClipRRect section with this:
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Stack(
                                  children: [
                                    // Background Image
                                    SizedBox(
                                      width: double.infinity,
                                      height: 200,
                                      child: CachedNetworkImage(
                                        imageUrl: meal.imageUrl,
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) =>
                                            Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Icon(Icons.restaurant,
                                              size: 50,
                                              color: Colors.grey[400]),
                                        ),
                                      ),
                                    ),
                                    // Text Overlay (Bottom gradient + name)
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.transparent,
                                              Colors.black.withOpacity(0.8),
                                            ],
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(12),
                                            bottomRight: Radius.circular(12),
                                          ),
                                        ),
                                        child: Text(
                                          meal.name.isNotEmpty
                                              ? meal.name
                                              : AppStrings.noName,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              Shadow(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                offset: Offset(0, 1),
                                                blurRadius: 4,
                                              ),
                                            ],
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: 230,
                        viewportFraction: 1.0,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        enlargeCenterPage: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          6, (index) => _buildProgressDot(context, index)),
                    ),
                  ],
                ),
                loading: () => SizedBox(
                  height: 200,
                  child: Center(
                      child: CircularProgressIndicator(color: Colors.red[700])),
                ),
                error: (error, stack) => Text(AppStrings.failedToLoadMeals + error.toString()),
              ),
              const SizedBox(height: 20),
              const CategoryCarousel(),
              randomMealsAsync.when(
                data: (meals) {
                  final index = random.nextInt(meals.length); // 0 .. length-1
                  final meal = meals[index];

                  return Column(
                    children: [
                      RandomMealCard(
                        imageUrl: meal.imageUrl,
                        title: meal.name,
                        subtitle1: meal.name,
                        subtitle2: meal.name,
                        onTap: () => _navigateToDetails(context, meal.id),
                      ),
                      const SizedBox(height: 24),
                    ],
                  );
                },
                loading: () => SizedBox(
                  height: 200,
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.red[700]),
                  ),
                ),
                error: (error, stack) => Text(AppStrings.failedToLoadMeals + error.toString()),
              ),
              const CuisineGrid(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressDot(BuildContext context, int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: currentIndex == index ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentIndex == index ? Colors.red[700]! : Colors.grey[400]!,
        boxShadow: currentIndex == index
            ? [
                BoxShadow(
                    color: Colors.red[700]!.withOpacity(0.4),
                    blurRadius: 8,
                    spreadRadius: 2)
              ]
            : null,
      ),
    );
  }

  void _navigateToDetails(BuildContext context, String mealId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CookingDetailsScreen(mealId: mealId),
      ),
    );
  }
}
