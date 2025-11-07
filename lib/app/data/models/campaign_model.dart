class CampaignModel {
  final int? id;
  final String? name;
  final String? image;
  final String? imageFullUrl;
  final String? restaurantName;
  final double? price;
  final double? discount;

  CampaignModel({
    this.id,
    this.name,
    this.image,
    this.imageFullUrl,
    this.restaurantName,
    this.price,
    this.discount,
  });

  factory CampaignModel.fromJson(Map<String, dynamic> json) {
    return CampaignModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      imageFullUrl: json['image_full_url'] as String?,
      restaurantName: json['restaurant_name'] as String?,
      price: _toDouble(json['price']),
      discount: _toDouble(json['discount']),
    );
  }

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'image_full_url': imageFullUrl,
      'restaurant_name': restaurantName,
      'price': price,
      'discount': discount,
    };
  }
}
