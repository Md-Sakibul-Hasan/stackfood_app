class RestaurantModel {
  final int? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? logo;
  final String? latitude;
  final String? longitude;
  final String? address;
  final double? minimumOrder;
  final String? currency;
  final bool? scheduleOrder;
  final int? status;
  final int? veg;
  final int? nonVeg;
  final String? availableTimeStarts;
  final String? availableTimeEnds;
  final double? avgRating;
  final int? ratingCount;
  final bool? gstStatus;
  final String? gstCode;
  final bool? freeDelivery;
  final String? coverPhoto;
  final String? coverPhotoFullUrl;
  final bool? delivery;
  final bool? takeAway;
  final bool? foodSection;
  final double? tax;
  final int? zoneId;
  final int? reviewsSection;
  final bool? active;
  final String? offDay;
  final int? selfDeliverySystem;
  final bool? posSystem;
  final double? minimumShippingCharge;
  final double? deliveryTime;
  final int? vendorId;
  final String? createdAt;
  final String? updatedAt;
  final bool? orderPlaceToScheduleInterval;
  final int? featured;
  final double? perKmShippingCharge;
  final String? restaurantModel;
  final double? maximumShippingCharge;
  final String? slug;
  final int? orderSubscriptionActive;

  RestaurantModel({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.logo,
    this.latitude,
    this.longitude,
    this.address,
    this.minimumOrder,
    this.currency,
    this.scheduleOrder,
    this.status,
    this.veg,
    this.nonVeg,
    this.availableTimeStarts,
    this.availableTimeEnds,
    this.avgRating,
    this.ratingCount,
    this.gstStatus,
    this.gstCode,
    this.freeDelivery,
    this.coverPhoto,
    this.coverPhotoFullUrl,
    this.delivery,
    this.takeAway,
    this.foodSection,
    this.tax,
    this.zoneId,
    this.reviewsSection,
    this.active,
    this.offDay,
    this.selfDeliverySystem,
    this.posSystem,
    this.minimumShippingCharge,
    this.deliveryTime,
    this.vendorId,
    this.createdAt,
    this.updatedAt,
    this.orderPlaceToScheduleInterval,
    this.featured,
    this.perKmShippingCharge,
    this.restaurantModel,
    this.maximumShippingCharge,
    this.slug,
    this.orderSubscriptionActive,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      logo: json['logo'] as String?,
      latitude: json['latitude']?.toString(),
      longitude: json['longitude']?.toString(),
      address: json['address'] as String?,
      minimumOrder: _toDouble(json['minimum_order']),
      currency: json['currency'] as String?,
      scheduleOrder: _toBool(json['schedule_order']),
      status: _toInt(json['status']),
      veg: _toInt(json['veg']),
      nonVeg: _toInt(json['non_veg']),
      availableTimeStarts: json['available_time_starts'] as String?,
      availableTimeEnds: json['available_time_ends'] as String?,
      avgRating: _toDouble(json['avg_rating']),
      ratingCount: json['rating_count'] as int?,
      gstStatus: _toBool(json['gst_status']),
      gstCode: json['gst_code'] as String?,
      freeDelivery: _toBool(json['free_delivery']),
      coverPhoto: json['cover_photo'] as String?,
      coverPhotoFullUrl: json['cover_photo_full_url'] as String?,
      delivery: _toBool(json['delivery']),
      takeAway: _toBool(json['take_away']),
      foodSection: _toBool(json['food_section']),
      tax: _toDouble(json['tax']),
      zoneId: json['zone_id'] as int?,
      reviewsSection: _toInt(json['reviews_section']),
      active: _toBool(json['active']),
      offDay: json['off_day'] as String?,
      selfDeliverySystem: _toInt(json['self_delivery_system']),
      posSystem: _toBool(json['pos_system']),
      minimumShippingCharge: _toDouble(json['minimum_shipping_charge']),
      deliveryTime: _toDouble(json['delivery_time']),
      vendorId: json['vendor_id'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      orderPlaceToScheduleInterval:
          _toBool(json['order_place_to_schedule_interval']),
      featured: _toInt(json['featured']),
      perKmShippingCharge: _toDouble(json['per_km_shipping_charge']),
      restaurantModel: json['restaurant_model'] as String?,
      maximumShippingCharge: _toDouble(json['maximum_shipping_charge']),
      slug: json['slug'] as String?,
      orderSubscriptionActive: _toInt(json['order_subscription_active']),
    );
  }

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is bool) return value ? 1 : 0;
    if (value is String) return int.tryParse(value);
    return null;
  }

  static bool? _toBool(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value;
    if (value is int) return value == 1;
    if (value is String) return value == '1' || value.toLowerCase() == 'true';
    return null;
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
      'phone': phone,
      'email': email,
      'logo': logo,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'minimum_order': minimumOrder,
      'currency': currency,
      'schedule_order': scheduleOrder,
      'status': status,
      'veg': veg,
      'non_veg': nonVeg,
      'available_time_starts': availableTimeStarts,
      'available_time_ends': availableTimeEnds,
      'avg_rating': avgRating,
      'rating_count': ratingCount,
      'gst_status': gstStatus,
      'gst_code': gstCode,
      'free_delivery': freeDelivery,
      'cover_photo': coverPhoto,
      'cover_photo_full_url': coverPhotoFullUrl,
      'delivery': delivery,
      'take_away': takeAway,
      'food_section': foodSection,
      'tax': tax,
      'zone_id': zoneId,
      'reviews_section': reviewsSection,
      'active': active,
      'off_day': offDay,
      'self_delivery_system': selfDeliverySystem,
      'pos_system': posSystem,
      'minimum_shipping_charge': minimumShippingCharge,
      'delivery_time': deliveryTime,
      'vendor_id': vendorId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'order_place_to_schedule_interval': orderPlaceToScheduleInterval,
      'featured': featured,
      'per_km_shipping_charge': perKmShippingCharge,
      'restaurant_model': restaurantModel,
      'maximum_shipping_charge': maximumShippingCharge,
      'slug': slug,
      'order_subscription_active': orderSubscriptionActive,
    };
  }
}
