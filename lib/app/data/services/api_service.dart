import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stackfood_app/app/data/constants/api_constants.dart';
import 'package:stackfood_app/app/data/models/banner_model.dart';
import 'package:stackfood_app/app/data/models/campaign_model.dart';
import 'package:stackfood_app/app/data/models/category_model.dart';
import 'package:stackfood_app/app/data/models/config_model.dart';
import 'package:stackfood_app/app/data/models/product_model.dart';
import 'package:stackfood_app/app/data/models/restaurant_model.dart';

class ApiService {
  final http.Client _client = http.Client();

  // Get Configuration
  Future<ConfigModel?> getConfig() async {
    try {
      final response = await _client.get(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.configEndpoint}'),
        headers: ApiConstants.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ConfigModel.fromJson(data);
      } else {
        throw Exception('Failed to load config: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching config: $e');
      return null;
    }
  }

  // Get Banners
  Future<List<BannerModel>> getBanners() async {
    try {
      final response = await _client.get(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.bannerEndpoint}'),
        headers: ApiConstants.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> bannerList =
            data['banners'] is List ? data['banners'] : [];

        // If empty, return fallback data
        if (bannerList.isEmpty) {
          return _getFallbackBanners();
        }

        return bannerList.map((json) => BannerModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load banners: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching banners: $e');
      return _getFallbackBanners();
    }
  }

  // Fallback banners data
  List<BannerModel> _getFallbackBanners() {
    final fallbackData = [
      {
        "id": 1,
        "title": "Offer",
        "type": "restaurant_wise",
        "image": "2024-12-22-6767f2f78747b.png",
        "image_full_url":
            "https://stackfood-admin.6amtech.com/storage/banner/2024-12-22-6767f2f78747b.png"
      },
      {
        "id": 4,
        "title": "Fast Delivery",
        "type": "restaurant_wise",
        "image": "2024-12-08-675672605c3cf.png",
        "image_full_url":
            "https://stackfood-admin.6amtech.com/storage/banner/2024-12-08-675672605c3cf.png"
      },
      {
        "id": 5,
        "title": "Local",
        "type": "restaurant_wise",
        "image": "2024-12-22-6767f307e27a2.png",
        "image_full_url":
            "https://stackfood-admin.6amtech.com/storage/banner/2024-12-22-6767f307e27a2.png"
      },
      {
        "id": 6,
        "title": "Korean Food",
        "type": "restaurant_wise",
        "image": "2024-12-08-675677579b964.png",
        "image_full_url":
            "https://stackfood-admin.6amtech.com/storage/banner/2024-12-08-675677579b964.png"
      },
      {
        "id": 8,
        "title": "Biryani",
        "type": "restaurant_wise",
        "image": "2024-12-22-6767f29c37d59.png",
        "image_full_url":
            "https://stackfood-admin.6amtech.com/storage/banner/2024-12-22-6767f29c37d59.png"
      }
    ];

    return fallbackData.map((json) => BannerModel.fromJson(json)).toList();
  }

  // Get Categories
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await _client.get(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.categoryEndpoint}'),
        headers: ApiConstants.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> categoryList = data is List ? data : [];
        return categoryList
            .map((json) => CategoryModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }

  // Get Popular Food
  Future<List<ProductModel>> getPopularFood() async {
    try {
      final response = await _client.get(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.popularFoodEndpoint}'),
        headers: ApiConstants.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> productList =
            data['products'] is List ? data['products'] : [];
        return productList.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load popular food: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching popular food: $e');
      return [];
    }
  }

  // Get Food Campaigns
  Future<List<CampaignModel>> getFoodCampaigns() async {
    try {
      final response = await _client.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.foodCampaignEndpoint}'),
        headers: ApiConstants.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> campaignList = data is List ? data : [];
        return campaignList
            .map((json) => CampaignModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load campaigns: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching campaigns: $e');
      return [];
    }
  }

  // Get Restaurants
  Future<List<RestaurantModel>> getRestaurants({
    int offset = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _client.get(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.restaurantsEndpoint}?offset=$offset&limit=$limit'),
        headers: ApiConstants.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Handle different response structures
        List<dynamic> restaurantList = [];
        if (data is Map && data.containsKey('restaurants')) {
          restaurantList = data['restaurants'];
        } else if (data is List) {
          restaurantList = data;
        }

        return restaurantList
            .map((json) => RestaurantModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load restaurants: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching restaurants: $e');
      return [];
    }
  }

  void dispose() {
    _client.close();
  }
}
