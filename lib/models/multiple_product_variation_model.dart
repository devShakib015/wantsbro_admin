import 'dart:convert';

import 'package:flutter/foundation.dart';

class MultipleProductVariationModel {
  Map<String, dynamic> attributes;
  double originalPrice;
  double salePrice;
  int stockCount;
  int soldCount;
  String variationImageUrl;
  MultipleProductVariationModel({
    this.attributes,
    this.originalPrice,
    this.salePrice,
    this.stockCount,
    this.soldCount,
    this.variationImageUrl,
  });

  MultipleProductVariationModel copyWith({
    Map<String, dynamic> attributes,
    double originalPrice,
    double salePrice,
    int stockCount,
    int soldCount,
    String variationImageUrl,
  }) {
    return MultipleProductVariationModel(
      attributes: attributes ?? this.attributes,
      originalPrice: originalPrice ?? this.originalPrice,
      salePrice: salePrice ?? this.salePrice,
      stockCount: stockCount ?? this.stockCount,
      soldCount: soldCount ?? this.soldCount,
      variationImageUrl: variationImageUrl ?? this.variationImageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'attributes': attributes,
      'originalPrice': originalPrice,
      'salePrice': salePrice,
      'stockCount': stockCount,
      'soldCount': soldCount,
      'variationImageUrl': variationImageUrl,
    };
  }

  factory MultipleProductVariationModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MultipleProductVariationModel(
      attributes: Map<String, dynamic>.from(map['attributes']),
      originalPrice: map['originalPrice'],
      salePrice: map['salePrice'],
      stockCount: map['stockCount'],
      soldCount: map['soldCount'],
      variationImageUrl: map['variationImageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MultipleProductVariationModel.fromJson(String source) =>
      MultipleProductVariationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MultipleProductVariationModel(attributes: $attributes, originalPrice: $originalPrice, salePrice: $salePrice, stockCount: $stockCount, soldCount: $soldCount, variationImageUrl: $variationImageUrl)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MultipleProductVariationModel &&
        mapEquals(o.attributes, attributes) &&
        o.originalPrice == originalPrice &&
        o.salePrice == salePrice &&
        o.stockCount == stockCount &&
        o.soldCount == soldCount &&
        o.variationImageUrl == variationImageUrl;
  }

  @override
  int get hashCode {
    return attributes.hashCode ^
        originalPrice.hashCode ^
        salePrice.hashCode ^
        stockCount.hashCode ^
        soldCount.hashCode ^
        variationImageUrl.hashCode;
  }
}
