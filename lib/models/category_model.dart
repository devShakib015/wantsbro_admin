import 'dart:convert';

class CategoryModel {
  String name;
  String parentID;
  String imageUrl;
  CategoryModel({
    this.name,
    this.parentID,
    this.imageUrl,
  });

  CategoryModel copyWith({
    String name,
    String parentID,
    String imageUrl,
  }) {
    return CategoryModel(
      name: name ?? this.name,
      parentID: parentID ?? this.parentID,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'parentID': parentID,
      'imageUrl': imageUrl,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CategoryModel(
      name: map['name'],
      parentID: map['parentID'],
      imageUrl: map['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source));
}
