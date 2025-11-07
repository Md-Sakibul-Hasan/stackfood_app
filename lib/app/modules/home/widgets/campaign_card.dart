import 'package:flutter/material.dart';
import 'package:stackfood_app/app/data/constants/app_colors.dart';
import 'package:stackfood_app/app/data/constants/app_dimensions.dart';
import 'package:stackfood_app/app/data/models/campaign_model.dart';
import 'package:stackfood_app/app/modules/home/widgets/custom_cached_image.dart';

class CampaignCard extends StatelessWidget {
  final CampaignModel campaign;

  final VoidCallback? onTap;

  const CampaignCard({
    super.key,
    required this.campaign,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double discountPercentage = campaign.discount ?? 0;
    final double originalPrice = campaign.price ?? 0;
    final double discountedPrice =
        originalPrice - (originalPrice * discountPercentage / 100);

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(right: AppDimensions.paddingSmall),
            width: 285,
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: AppDimensions.extraSmallPadding),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              children: [
                // Campaign Image
                Container(
                  width: 85,
                  height: 85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.background,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CustomCachedImage(
                      imageUrl: campaign.imageFullUrl ?? '',
                      width: 110,
                      height: 110,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Campaign Details
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Campaign Title
                      Text(
                        campaign.name ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: AppDimensions.fontSizeMedium,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2B3D4F),
                          letterSpacing: -0.5,
                        ),
                      ),

                      // Restaurant Name
                      Text(
                        campaign.restaurantName ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: AppDimensions.fontSizeMedium,
                          color: Colors.grey[600],
                          letterSpacing: 0,
                        ),
                      ),

                      // Rating Stars
                      Row(
                        children: List.generate(5, (index) {
                          return const Icon(
                            Icons.star,
                            size: 15,
                            color: AppColors.discountBadge,
                          );
                        }),
                      ),

                      // Price Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Price
                          Row(
                            children: [
                              Text(
                                '\$${discountedPrice.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontSize: AppDimensions.fontSizeMedium,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2B3D4F),
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (discountPercentage > 0)
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Text(
                                      '\$${originalPrice.toStringAsFixed(0)}',
                                      style: TextStyle(
                                        fontSize: AppDimensions.fontSizeMedium,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    CustomPaint(
                                      size: const Size(36, 8),
                                      painter: DiagonalLinePainter(
                                        color: Colors.grey[400]!,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),

                          // Plus Button
                          const Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 28,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Discount Badge - positioned over the card
          if (discountPercentage > 0)
            Positioned(
              top: 24,
              left: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 5,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.discountBadge,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                ),
                child: Text(
                  '${discountPercentage.toStringAsFixed(0)}% off',
                  style: const TextStyle(
                    fontSize: AppDimensions.fontSizeMedium,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Custom painter for diagonal line from top-right to bottom-left
class DiagonalLinePainter extends CustomPainter {
  final Color color;

  DiagonalLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    // Draw line from top-right to bottom-left
    canvas.drawLine(
      Offset(size.width, 0), // Top-right
      Offset(0, size.height), // Bottom-left
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
