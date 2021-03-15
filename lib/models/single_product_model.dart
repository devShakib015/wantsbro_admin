import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:wantsbro_admin/models/product_model.dart';

class SingleProductModel extends ProductModel {
  String title;
  String parentCategoryID;
  String parentCategoryName;
  String childCategoryID;
  String childCategoryName;
  bool isSingle;
  String description;
  String weight;
  String size;
  double originalPrice;
  double salePrice;
  int stockCount;
  int soldCount;
  List<dynamic> featuredImages;
  List<dynamic> descImages;
  SingleProductModel({
    this.title,
    this.parentCategoryID,
    this.parentCategoryName,
    this.childCategoryID,
    this.childCategoryName,
    this.isSingle,
    this.description,
    this.weight,
    this.size,
    this.originalPrice,
    this.salePrice,
    this.stockCount,
    this.soldCount,
    this.featuredImages,
    this.descImages,
  }) : super(
            title: title,
            childCategoryID: childCategoryID,
            childCategoryName: childCategoryName,
            description: description,
            parentCategoryID: parentCategoryID,
            parentCategoryName: parentCategoryName);

  SingleProductModel copyWith({
    String title,
    String parentCategoryID,
    String parentCategoryName,
    String childCategoryID,
    String childCategoryName,
    bool isSingle,
    String description,
    String weight,
    String size,
    double originalPrice,
    double salePrice,
    int stockCount,
    int soldCount,
    List<dynamic> featuredImages,
    List<dynamic> descImages,
  }) {
    return SingleProductModel(
      title: title ?? this.title,
      parentCategoryID: parentCategoryID ?? this.parentCategoryID,
      parentCategoryName: parentCategoryName ?? this.parentCategoryName,
      childCategoryID: childCategoryID ?? this.childCategoryID,
      childCategoryName: childCategoryName ?? this.childCategoryName,
      isSingle: isSingle ?? this.isSingle,
      description: description ?? this.description,
      weight: weight ?? this.weight,
      size: size ?? this.size,
      originalPrice: originalPrice ?? this.originalPrice,
      salePrice: salePrice ?? this.salePrice,
      stockCount: stockCount ?? this.stockCount,
      soldCount: soldCount ?? this.soldCount,
      featuredImages: featuredImages ?? this.featuredImages,
      descImages: descImages ?? this.descImages,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'parentCategoryID': parentCategoryID,
      'parentCategoryName': parentCategoryName,
      'childCategoryID': childCategoryID,
      'childCategoryName': childCategoryName,
      'isSingle': isSingle,
      'description': description,
      'weight': weight,
      'size': size,
      'originalPrice': originalPrice,
      'salePrice': salePrice,
      'stockCount': stockCount,
      'soldCount': soldCount,
      'featuredImages': featuredImages,
      'descImages': descImages,
    };
  }

  factory SingleProductModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SingleProductModel(
      title: map['title'],
      parentCategoryID: map['parentCategoryID'],
      parentCategoryName: map['parentCategoryName'],
      childCategoryID: map['childCategoryID'],
      childCategoryName: map['childCategoryName'],
      isSingle: map['isSingle'],
      description: map['description'],
      weight: map['weight'],
      size: map['size'],
      originalPrice: map['originalPrice'],
      salePrice: map['salePrice'],
      stockCount: map['stockCount'],
      soldCount: map['soldCount'],
      featuredImages: List<dynamic>.from(map['featuredImages']),
      descImages: List<dynamic>.from(map['descImages']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SingleProductModel.fromJson(String source) =>
      SingleProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SingleProductModel(title: $title, parentCategoryID: $parentCategoryID, parentCategoryName: $parentCategoryName, childCategoryID: $childCategoryID, childCategoryName: $childCategoryName, isSingle: $isSingle, description: $description, weight: $weight, size: $size, originalPrice: $originalPrice, salePrice: $salePrice, stockCount: $stockCount, soldCount: $soldCount, featuredImages: $featuredImages, descImages: $descImages)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SingleProductModel &&
        o.title == title &&
        o.parentCategoryID == parentCategoryID &&
        o.parentCategoryName == parentCategoryName &&
        o.childCategoryID == childCategoryID &&
        o.childCategoryName == childCategoryName &&
        o.isSingle == isSingle &&
        o.description == description &&
        o.weight == weight &&
        o.size == size &&
        o.originalPrice == originalPrice &&
        o.salePrice == salePrice &&
        o.stockCount == stockCount &&
        o.soldCount == soldCount &&
        listEquals(o.featuredImages, featuredImages) &&
        listEquals(o.descImages, descImages);
  }

  @override
  int get hashCode {
    return title.hashCode ^
        parentCategoryID.hashCode ^
        parentCategoryName.hashCode ^
        childCategoryID.hashCode ^
        childCategoryName.hashCode ^
        isSingle.hashCode ^
        description.hashCode ^
        weight.hashCode ^
        size.hashCode ^
        originalPrice.hashCode ^
        salePrice.hashCode ^
        stockCount.hashCode ^
        soldCount.hashCode ^
        featuredImages.hashCode ^
        descImages.hashCode;
  }
}
