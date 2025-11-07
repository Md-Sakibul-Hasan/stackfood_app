import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stackfood_app/app/data/constants/app_dimensions.dart';

class ShimmerLoading {
  static Widget categoryShimmer() {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 80,
              margin: EdgeInsets.only(
                left: index == 0 ? AppDimensions.paddingMedium : 0,
                right: AppDimensions.paddingMedium,
              ),
              child: Column(
                children: [
                  Container(
                    width: AppDimensions.categoryIconSize,
                    height: AppDimensions.categoryIconSize,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusMedium),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 60,
                    height: 12,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  static Widget foodCardShimmer() {
    return SizedBox(
      height: AppDimensions.foodCardHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: AppDimensions.foodCardWidth,
              margin: EdgeInsets.only(
                left: index == 0 ? AppDimensions.paddingMedium : 0,
                right: AppDimensions.paddingMedium,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              ),
            ),
          );
        },
      ),
    );
  }

  static Widget campaignCardShimmer() {
    return SizedBox(
      height: AppDimensions.campaignCardHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 280,
              margin: EdgeInsets.only(
                left: index == 0 ? AppDimensions.paddingMedium : 0,
                right: AppDimensions.paddingMedium,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              ),
            ),
          );
        },
      ),
    );
  }

  static Widget restaurantCardShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium,
          vertical: AppDimensions.paddingSmall,
        ),
        height: AppDimensions.restaurantCardHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
      ),
    );
  }

  static Widget bannerShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin:
            const EdgeInsets.symmetric(horizontal: AppDimensions.paddingMedium),
        height: AppDimensions.bannerHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
      ),
    );
  }
}
