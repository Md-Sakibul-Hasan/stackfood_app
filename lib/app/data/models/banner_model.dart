class BannerModel {
  final int? id;
  final String? title;
  final String? image;
  final String? imageFullUrl;

  BannerModel({
    this.id,
    this.title,
    this.image,
    this.imageFullUrl,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      image: json['image'] as String?,
      imageFullUrl: json['image_full_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'image_full_url': imageFullUrl,
    };
  }
}
