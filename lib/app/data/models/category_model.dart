class CategoryModel {
  final int? id;
  final String? name;
  final String? image;
  final String? imageFullUrl;

  CategoryModel({
    this.id,
    this.name,
    this.image,
    this.imageFullUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      imageFullUrl: json['image_full_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'image_full_url': imageFullUrl,
    };
  }
}
