import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' hide RefreshIndicator;
import 'package:stackfood_app/app/data/constants/app_colors.dart';
import 'package:stackfood_app/app/data/constants/app_dimensions.dart';
import 'package:stackfood_app/app/data/constants/app_strings.dart';
import 'package:stackfood_app/app/modules/home/controllers/config_controller.dart';
import 'package:stackfood_app/app/modules/home/controllers/home_controller.dart';
import 'package:stackfood_app/app/modules/home/widgets/campaign_card.dart';
import 'package:stackfood_app/app/modules/home/widgets/category_card.dart';
import 'package:stackfood_app/app/modules/home/widgets/custom_cached_image.dart';
import 'package:stackfood_app/app/modules/home/widgets/food_card.dart';
import 'package:stackfood_app/app/modules/home/widgets/restaurant_card.dart';
import 'package:stackfood_app/app/modules/home/widgets/shimmer_loading.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final configController = Get.find<ConfigController>();
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= AppDimensions.desktopBreakpoint;
    final isTablet =
        screenWidth >= AppDimensions.tabletBreakpoint && !isDesktop;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SmartRefresher(
          controller: controller.refreshController,
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: controller.refreshData,
          onLoading: controller.loadMoreRestaurants,
          header: const WaterDropMaterialHeader(
            backgroundColor: AppColors.primary,
            color: Colors.white,
          ),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus? mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = const Text("Pull up to load more");
              } else if (mode == LoadStatus.loading) {
                body = const CircularProgressIndicator();
              } else if (mode == LoadStatus.failed) {
                body = const Text("Load Failed! Click retry!");
              } else if (mode == LoadStatus.canLoading) {
                body = const Text("Release to load more");
              } else {
                body = const Text("No more restaurants");
              }
              return Container(
                height: 120.0,
                padding: const EdgeInsets.only(
                    bottom: 93.0), // Add padding instead of margin
                child: Center(child: body),
              );
            },
          ),
          child: CustomScrollView(
            slivers: [
              // App Bar
              SliverToBoxAdapter(
                child: _buildAppBar(context),
              ),

              // Search Bar
              SliverToBoxAdapter(
                child: _buildSearchBar(context),
              ),

              // Banner Carousel
              SliverToBoxAdapter(
                child: _buildBannerSection(configController),
              ),

              // Categories Section
              SliverToBoxAdapter(
                child: _buildSectionHeader(
                  title: AppStrings.categories,
                  onViewAllTap: () {},
                ),
              ),
              SliverToBoxAdapter(
                child: _buildCategoriesSection(
                    configController, isDesktop, isTablet),
              ),

              // Popular Food Section
              SliverToBoxAdapter(
                child: _buildSectionHeader(
                  title: AppStrings.popularFoodNearby,
                  onViewAllTap: () {},
                ),
              ),
              SliverToBoxAdapter(
                child: _buildPopularFoodSection(configController),
              ),

              // Food Campaign Section
              SliverToBoxAdapter(
                child: _buildSectionHeader(
                  title: AppStrings.foodCampaign,
                  onViewAllTap: () {},
                ),
              ),
              SliverToBoxAdapter(
                child: _buildCampaignSection(configController),
              ),

              // Restaurants Section
              SliverToBoxAdapter(
                child: _buildSectionHeader(
                  title: AppStrings.restaurants,
                  onViewAllTap: () {},
                ),
              ),

              // Restaurants List
              _buildRestaurantsSection(),
            ],
          ),
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar:
          _buildBottomNavigationBar(), // Floating Action Button
      floatingActionButton: _buildCartFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.extraSmallPadding,
          horizontal: AppDimensions.paddingMedium),
      child: Row(
        children: [
          const Icon(
            Icons.home,
            color: Colors.grey,
            size: AppDimensions.iconSizeMedium,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '76A eighth avenue, New York, US',
                  style: TextStyle(
                    fontSize: AppDimensions.fontSizeMedium,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.notifications,
                  color: AppColors.textPrimary,
                ),
                onPressed: () {},
              ),
              Positioned(
                right: 14,
                top: 13,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
        vertical: AppDimensions.paddingSmall,
      ),
      padding:
          const EdgeInsets.symmetric(horizontal: AppDimensions.paddingMedium),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: AppStrings.searchHint,
                hintStyle: TextStyle(
                  color: AppColors.textLight,
                  fontSize: AppDimensions.fontSizeMedium,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          Icon(
            Icons.search,
            color: AppColors.textLight,
          ),
        ],
      ),
    );
  }

  Widget _buildBannerSection(ConfigController configController) {
    return Obx(() {
      if (controller.isBannersLoading.value) {
        return Padding(
          padding: const EdgeInsets.symmetric(
              vertical: AppDimensions.extraSmallPadding),
          child: ShimmerLoading.bannerShimmer(),
        );
      }

      if (controller.banners.isEmpty) {
        return const SizedBox.shrink();
      }

      return Padding(
        padding: const EdgeInsets.only(top: AppDimensions.paddingMedium),
        child: Column(
          children: [
            SizedBox(
              height: AppDimensions.bannerHeight,
              child: PageView.builder(
                itemCount: controller.banners.length,
                controller: controller.bannerPageController,
                onPageChanged: (index) {
                  controller.currentBannerIndex.value = index;
                },
                itemBuilder: (context, index) {
                  final banner = controller.banners[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    child: CustomCachedImage(
                      imageUrl: banner.imageFullUrl ?? '',
                      width: double.infinity,
                      height: AppDimensions.bannerHeight,
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusMedium),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            // Dot Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                controller.banners.length,
                (index) => Obx(() {
                  final isActive = controller.currentBannerIndex.value == index;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 10 : 8,
                    height: isActive ? 10 : 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive ? AppColors.success : Colors.grey[300],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildSectionHeader({
    required String title,
    required VoidCallback onViewAllTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppDimensions.paddingMedium,
        right: AppDimensions.extraSmallPadding,
        top: AppDimensions.extraSmallPadding,
        bottom: AppDimensions.paddingSmall,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: AppDimensions.fontSizeTitle,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          TextButton(
            onPressed: onViewAllTap,
            child: const Text(
              AppStrings.viewAll,
              style: TextStyle(
                fontSize: AppDimensions.fontSizeMedium,
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection(
    ConfigController configController,
    bool isDesktop,
    bool isTablet,
  ) {
    return Obx(() {
      if (controller.isCategoriesLoading.value) {
        return ShimmerLoading.categoryShimmer();
      }

      if (controller.categories.isEmpty) {
        return const SizedBox.shrink();
      }

      if (isDesktop || isTablet) {
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMedium),
          child: Wrap(
            spacing: AppDimensions.paddingMedium,
            runSpacing: AppDimensions.paddingMedium,
            children: controller.categories.map((category) {
              return CategoryCard(
                category: category,
                imageBaseUrl: configController.businessImageUrl,
                onTap: () {},
              );
            }).toList(),
          ),
        );
      }

      return SizedBox(
        height: 90,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            final category = controller.categories[index];
            return Padding(
              padding: EdgeInsets.only(
                left: index == 0 ? AppDimensions.extraSmallPadding : 0,
              ),
              child: CategoryCard(
                category: category,
                imageBaseUrl: configController.businessImageUrl,
                onTap: () {},
              ),
            );
          },
        ),
      );
    });
  }

  Widget _buildPopularFoodSection(ConfigController configController) {
    return Obx(() {
      if (controller.isPopularFoodsLoading.value) {
        return ShimmerLoading.foodCardShimmer();
      }

      if (controller.popularFoods.isEmpty) {
        return const SizedBox.shrink();
      }

      return SizedBox(
        height: AppDimensions.foodCardHeight,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.popularFoods.length,
          itemBuilder: (context, index) {
            final food = controller.popularFoods[index];
            return Padding(
              padding: EdgeInsets.only(
                left: index == 0 ? AppDimensions.paddingMedium : 0,
                right: AppDimensions.paddingMedium,
              ),
              child: FoodCard(
                product: food,
                imageUrl: controller.popularFoods[index].imageFullUrl ?? '',
                onTap: () {},
              ),
            );
          },
        ),
      );
    });
  }

  Widget _buildCampaignSection(ConfigController configController) {
    return Obx(() {
      if (controller.isCampaignsLoading.value) {
        return ShimmerLoading.campaignCardShimmer();
      }

      if (controller.campaigns.isEmpty) {
        return const SizedBox.shrink();
      }

      return SizedBox(
        height: AppDimensions.campaignCardHeight,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.campaigns.length,
          padding: const EdgeInsets.only(left: AppDimensions.paddingMedium),
          itemBuilder: (context, index) {
            final campaign = controller.campaigns[index];
            return CampaignCard(
              campaign: campaign,
              onTap: () {},
            );
          },
        ),
      );
    });
  }

  Widget _buildRestaurantsSection() {
    return Obx(() {
      if (controller.isRestaurantsLoading.value &&
          controller.restaurants.isEmpty) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ShimmerLoading.restaurantCardShimmer(),
            childCount: 3,
          ),
        );
      }

      if (controller.restaurants.isEmpty) {
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      }

      return SliverPadding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppDimensions.paddingMedium),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final restaurant = controller.restaurants[index];
              return RestaurantCard(
                restaurant: restaurant,
                onTap: () {},
              );
            },
            childCount: controller.restaurants.length,
          ),
        ),
      );
    });
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.white,
        elevation: 0,
        child: SizedBox(
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, true),
              _buildNavItem(Icons.favorite_border, false),
              const SizedBox(width: 40), // Space for FAB
              _buildNavItem(Icons.receipt_long, false),
              _buildNavItem(Icons.menu, false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isActive) {
    return InkWell(
      onTap: () {},
      child: Icon(
        icon,
        color: isActive ? AppColors.primary : AppColors.textSecondary,
        size: 28,
      ),
    );
  }

  Widget _buildCartFAB() {
    return SizedBox(
      width: 75,
      height: 75,
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Icon(
          Icons.shopping_cart,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
