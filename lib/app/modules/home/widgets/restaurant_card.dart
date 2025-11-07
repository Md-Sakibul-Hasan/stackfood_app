import 'package:flutter/material.dart';
import 'package:stackfood_app/app/data/models/restaurant_model.dart';
import 'package:stackfood_app/app/modules/home/widgets/custom_cached_image.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantModel restaurant;

  final VoidCallback? onTap;

  const RestaurantCard({
    super.key,
    required this.restaurant,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Restaurant Image - Rounded Square
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CustomCachedImage(
                imageUrl: restaurant.coverPhotoFullUrl ?? '',
                width: 80,
                height: 80,
              ),
            ),
            const SizedBox(width: 12),

            // Restaurant Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Item Name
                  Text(
                    restaurant.name ?? 'Item Name',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1D26),
                    ),
                  ),
                  const SizedBox(height: 2),

                  // Restaurant Name
                  Text(
                    restaurant.address ?? 'Mc Donald',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF9CA4AB),
                    ),
                  ),
                  const SizedBox(height: 2),

                  // Rating Stars and Price
                  Row(
                    children: [
                      // 5 Star Icons
                      ...List.generate(
                        5,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: 2),
                          child: Icon(
                            index < (restaurant.avgRating?.floor() ?? 0)
                                ? Icons.star
                                : Icons.star_border,
                            size: 16,
                            color: const Color(0xFF4CAF50),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),

                  /// Price
                  Text(
                    '\$${restaurant.minimumOrder?.toStringAsFixed(2) ?? '5.55'}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1D26),
                    ),
                  ),
                ],
              ),
            ),

            // Right side icons
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Favorite Icon
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_border,
                    color: Color(0xFF9CA4AB),
                    size: 24,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(height: 20),

                // Add Icon
                const Icon(
                  Icons.add,
                  color: Color(0xFF1A1D26),
                  size: 28,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
