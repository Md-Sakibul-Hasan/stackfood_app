import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stackfood_app/app/data/models/banner_model.dart';
import 'package:stackfood_app/app/data/models/campaign_model.dart';
import 'package:stackfood_app/app/data/models/category_model.dart';
import 'package:stackfood_app/app/data/models/product_model.dart';
import 'package:stackfood_app/app/data/models/restaurant_model.dart';
import 'package:stackfood_app/app/data/services/api_service.dart';
import 'package:stackfood_app/app/modules/home/controllers/config_controller.dart';

class HomeController extends GetxController {
  final ApiService _apiService = ApiService();
  final ConfigController configController = Get.find<ConfigController>();

  // Refresh Controller for pagination
  late RefreshController refreshController;

  // Observable Lists
  final RxList<BannerModel> banners = <BannerModel>[].obs;
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxList<ProductModel> popularFoods = <ProductModel>[].obs;
  final RxList<CampaignModel> campaigns = <CampaignModel>[].obs;
  final RxList<RestaurantModel> restaurants = <RestaurantModel>[].obs;

  // Loading States
  final RxBool isBannersLoading = false.obs;
  final RxBool isCategoriesLoading = false.obs;
  final RxBool isPopularFoodsLoading = false.obs;
  final RxBool isCampaignsLoading = false.obs;
  final RxBool isRestaurantsLoading = false.obs;

  // Banner Carousel State
  final RxInt currentBannerIndex = 2.obs;

  // Error States
  final RxString bannersError = ''.obs;
  final RxString categoriesError = ''.obs;
  final RxString popularFoodsError = ''.obs;
  final RxString campaignsError = ''.obs;
  final RxString restaurantsError = ''.obs;

  // Pagination
  final RxInt restaurantOffset = 1.obs;
  final RxBool hasMoreRestaurants = true.obs;

  @override
  void onInit() {
    super.onInit();
    refreshController = RefreshController(initialRefresh: false);
    fetchAllData();
  }

  Future<void> fetchAllData() async {
    await Future.wait([
      fetchBanners(),
      fetchCategories(),
      fetchPopularFoods(),
      fetchCampaigns(),
      fetchRestaurants(),
    ]);
  }

  Future<void> fetchBanners() async {
    try {
      isBannersLoading.value = true;
      bannersError.value = '';

      final result = await _apiService.getBanners();
      banners.value = result;
    } catch (e) {
      bannersError.value = 'Failed to load banners';
      print('Error fetching banners: $e');
    } finally {
      isBannersLoading.value = false;
    }
  }

  Future<void> fetchCategories() async {
    try {
      isCategoriesLoading.value = true;
      categoriesError.value = '';

      final result = await _apiService.getCategories();
      categories.value = result;
    } catch (e) {
      categoriesError.value = 'Failed to load categories';
      print('Error fetching categories: $e');
    } finally {
      isCategoriesLoading.value = false;
    }
  }

  Future<void> fetchPopularFoods() async {
    try {
      isPopularFoodsLoading.value = true;
      popularFoodsError.value = '';

      final result = await _apiService.getPopularFood();
      popularFoods.value = result;
    } catch (e) {
      popularFoodsError.value = 'Failed to load popular foods';
      print('Error fetching popular foods: $e');
    } finally {
      isPopularFoodsLoading.value = false;
    }
  }

  Future<void> fetchCampaigns() async {
    try {
      isCampaignsLoading.value = true;
      campaignsError.value = '';

      final result = await _apiService.getFoodCampaigns();
      campaigns.value = result;
    } catch (e) {
      campaignsError.value = 'Failed to load campaigns';
      print('Error fetching campaigns: $e');
    } finally {
      isCampaignsLoading.value = false;
    }
  }

  Future<void> fetchRestaurants({bool isLoadMore = false}) async {
    try {
      // Set loading state for both initial and load more
      isRestaurantsLoading.value = true;

      if (!isLoadMore) {
        restaurantOffset.value = 1;
      }

      restaurantsError.value = '';

      final result = await _apiService.getRestaurants(
        offset: restaurantOffset.value,
        limit: 10,
      );

      if (isLoadMore) {
        restaurants.addAll(result);
      } else {
        restaurants.value = result;
      }

      // Check if there are more restaurants to load
      // If we got exactly 10 or more, there might be more data
      hasMoreRestaurants.value = result.length == 10;

      // Only increment offset if we got data
      if (result.isNotEmpty && result.length == 10) {
        restaurantOffset.value += 10; // Increment by limit value
      }
    } catch (e) {
      restaurantsError.value = 'Failed to load restaurants';
      print('Error fetching restaurants: $e');
    } finally {
      isRestaurantsLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    restaurantOffset.value = 1;
    hasMoreRestaurants.value = true;
    await fetchAllData();
    refreshController.refreshCompleted();
  }

  Future<void> loadMoreRestaurants() async {
    if (!hasMoreRestaurants.value) {
      refreshController.loadNoData();
      return;
    }

    await fetchRestaurants(isLoadMore: true);

    if (hasMoreRestaurants.value) {
      refreshController.loadComplete();
    } else {
      refreshController.loadNoData();
    }
  }

  @override
  void onClose() {
    refreshController.dispose();
    _apiService.dispose();
    super.onClose();
  }
}
