import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:wantsbro_admin/models/product_model.dart';

class MultipleProductModel extends ProductModel {
  String title;
  String parentCategoryID;
  String parentCategoryName;
  String childCategoryID;
  String childCategoryName;
  String description;
  bool isSingle;
  List productVariation;
  List<dynamic> featuredImages;
  List<dynamic> descImages;

  MultipleProductModel({
    this.title,
    this.parentCategoryID,
    this.parentCategoryName,
    this.childCategoryID,
    this.childCategoryName,
    this.description,
    this.isSingle,
    this.productVariation,
    this.featuredImages,
    this.descImages,
  }) : super(
            title: title,
            childCategoryID: childCategoryID,
            childCategoryName: childCategoryName,
            description: description,
            parentCategoryID: parentCategoryID,
            parentCategoryName: parentCategoryName);

  MultipleProductModel copyWith({
    String title,
    String parentCategoryID,
    String parentCategoryName,
    String childCategoryID,
    String childCategoryName,
    String description,
    bool isSingle,
    List productVariation,
    List<dynamic> featuredImages,
    List<dynamic> descImages,
  }) {
    return MultipleProductModel(
      title: title ?? this.title,
      parentCategoryID: parentCategoryID ?? this.parentCategoryID,
      parentCategoryName: parentCategoryName ?? this.parentCategoryName,
      childCategoryID: childCategoryID ?? this.childCategoryID,
      childCategoryName: childCategoryName ?? this.childCategoryName,
      description: description ?? this.description,
      isSingle: isSingle ?? this.isSingle,
      productVariation: productVariation ?? this.productVariation,
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
      'description': description,
      'isSingle': isSingle,
      'productVariation': productVariation,
      'featuredImages': featuredImages,
      'descImages': descImages,
    };
  }

  factory MultipleProductModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MultipleProductModel(
      title: map['title'],
      parentCategoryID: map['parentCategoryID'],
      parentCategoryName: map['parentCategoryName'],
      childCategoryID: map['childCategoryID'],
      childCategoryName: map['childCategoryName'],
      description: map['description'],
      isSingle: map['isSingle'],
      productVariation: List.from(map['productVariation']?.map((x) => x)),
      featuredImages: List<dynamic>.from(map['featuredImages']),
      descImages: List<dynamic>.from(map['descImages']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MultipleProductModel.fromJson(String source) =>
      MultipleProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MultipleProductModel(title: $title, parentCategoryID: $parentCategoryID, parentCategoryName: $parentCategoryName, childCategoryID: $childCategoryID, childCategoryName: $childCategoryName, description: $description, isSingle: $isSingle, productVariation: $productVariation, featuredImages: $featuredImages, descImages: $descImages)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MultipleProductModel &&
        o.title == title &&
        o.parentCategoryID == parentCategoryID &&
        o.parentCategoryName == parentCategoryName &&
        o.childCategoryID == childCategoryID &&
        o.childCategoryName == childCategoryName &&
        o.description == description &&
        o.isSingle == isSingle &&
        listEquals(o.productVariation, productVariation) &&
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
        description.hashCode ^
        isSingle.hashCode ^
        productVariation.hashCode ^
        featuredImages.hashCode ^
        descImages.hashCode;
  }
}
