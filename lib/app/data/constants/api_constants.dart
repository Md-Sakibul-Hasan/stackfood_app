class ApiConstants {
  static const String baseUrl = 'https://stackfood-admin.6amtech.com';

  // API Endpoints
  static const String configEndpoint = '/api/v1/config';
  static const String bannerEndpoint = '/api/v1/banners';
  static const String categoryEndpoint = '/api/v1/categories';
  static const String popularFoodEndpoint = '/api/v1/products/popular';
  static const String foodCampaignEndpoint = '/api/v1/campaigns/item';
  static const String restaurantsEndpoint =
      '/api/v1/restaurants/get-restaurants/all';

  // API Headers
  static Map<String, String> get headers => {
        'Content-Type': 'application/json; charset=UTF-8',
        'zoneId': '[1]',
        'latitude': '23.735129',
        'longitude': '90.425614'
      };
}
