import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hopscotch_flutter_coding_r1/core/di/providers.dart';
import 'package:hopscotch_flutter_coding_r1/core/constants/app_strings.dart';
import '../../domain/entities/cousine.dart';  // Fixed: cousine.dart
import '../providers/home_provider.dart';

class CuisineGrid extends ConsumerWidget {
  const CuisineGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cuisineMealsAsync = ref.watch(cousineProvider); // Fixed provider name

    return cuisineMealsAsync.when(
      data: (cuisines) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.cuisineSection,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.8,  // Fixed: Slightly taller for text visibility
              crossAxisSpacing: 10,
              mainAxisSpacing: 12,
            ),
            itemCount: cuisines.length,
            itemBuilder: (context, index) {
              final cuisine = cuisines[index];
              return GestureDetector(
                onTap: () => _navigateToDetails(context, cuisine.id),
                child: Column(
                  children: [
                    // Fixed: Circle image with proper clipping
                    ClipOval(
                      child: SizedBox(
                        width: 50,  // Fixed size for circle
                        height: 50,
                        child: CachedNetworkImage(
                          imageUrl: cuisine.imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFB71C1C)),
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[200],
                            child: const Icon(
                              Icons.restaurant,
                              color: Color(0xFF757575),
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Fixed: Proper text container with null safety
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(
                          cuisine.name.isNotEmpty ? cuisine.name : AppStrings.noName,  // ← FIXED
                          style: const TextStyle(                       // ← FIXED
                            fontSize: 10,                                    // Increased from 8
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF212121),
                          ),
                          textAlign: TextAlign.center,                         // ← ADDED
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
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
      error: (error, stackTrace) => Padding(  // Fixed: Added stackTrace
        padding: const EdgeInsets.all(16.0),
        child: Text(
          AppStrings.failedToLoadCuisine + error.toString(),
          style: TextStyle(color: Colors.red[700]),
        ),
      ),
    );
  }

  void _navigateToDetails(BuildContext context, String cuisineId) {
    // TODO: Implement navigation
  }
}
