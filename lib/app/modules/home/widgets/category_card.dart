import 'package:flutter/material.dart';
import 'package:stackfood_app/app/data/constants/app_colors.dart';
import 'package:stackfood_app/app/data/constants/app_dimensions.dart';
import 'package:stackfood_app/app/data/models/category_model.dart';
import 'package:stackfood_app/app/modules/home/widgets/custom_cached_image.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final String imageBaseUrl;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.imageBaseUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 80,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              elevation: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                    Radius.circular(AppDimensions.radiusMedium)),
                child: CustomCachedImage(
                  imageUrl: category.imageFullUrl ?? '',
                  width: AppDimensions.categoryIconSize,
                  height: AppDimensions.categoryIconSize,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category.name ?? '',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: AppDimensions.fontSizeSmall,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
