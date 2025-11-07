class ConfigModel {
  final String? baseUrl;
  final String? imageBaseUrl;
  final String? businessName;
  final String? logo;
  final String? address;
  final String? phone;
  final String? email;
  final String? currency;

  ConfigModel({
    this.baseUrl,
    this.imageBaseUrl,
    this.businessName,
    this.logo,
    this.address,
    this.phone,
    this.email,
    this.currency,
  });

  factory ConfigModel.fromJson(Map<String, dynamic> json) {
    return ConfigModel(
      baseUrl: json['base_urls']?['business_image_url'] as String?,
      imageBaseUrl: json['base_urls']?['product_image_url'] as String?,
      businessName: json['business_name'] as String?,
      logo: json['logo'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      currency: json['currency_symbol'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'base_urls': {
        'business_image_url': baseUrl,
        'product_image_url': imageBaseUrl,
      },
      'business_name': businessName,
      'logo': logo,
      'address': address,
      'phone': phone,
      'email': email,
      'currency_symbol': currency,
    };
  }
}
