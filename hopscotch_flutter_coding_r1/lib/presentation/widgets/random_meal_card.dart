import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';


class RandomMealCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle1;
  final String subtitle2;
  final VoidCallback onTap;

  const RandomMealCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

 Text(
            'Star item of the day',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
               fontWeight: FontWeight.w600,
            ),
          ),

           const SizedBox(height: 8),

          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: double.infinity,
              height: 200,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[200],
                  child: Icon(Icons.restaurant, size: 40, color: Colors.grey[400]),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // 1st line – bold
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          // 2nd line – grey
          Text(
            'Classic recipe',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 2),
          // 3rd line – grey
          Text(
            'Delicious and easy to make',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
