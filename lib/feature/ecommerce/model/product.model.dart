import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class ProductModel {
  final String name;
  final List<String> imageUrls;
  final double cost;
  final String? description;
  final List<String>? sizes;
  final String categoryName;
  final String productType; // such as shirt, jeans, pet treats, etc

  const ProductModel({
    required this.name,
    required this.imageUrls,
    required this.cost,
    required this.categoryName,
    required this.productType,
    this.description,
    this.sizes,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] as String,
      imageUrls: map['imageUrls'] is List<dynamic>
          ? (map['imageUrls'] as List<dynamic>)
              .map((e) => e.toString())
              .toList()
          : [],
      cost: map['cost'] as double,
      description:
          map['description'] != null ? map['description'] as String : null,
      sizes: map['sizes'] is List<String>?
          ? List<String>.from((map['sizes'] as List<String>))
          : null,
      categoryName: map['category'] as String,
      productType: map['productType'] as String,
    );
  }

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
