import 'package:flutter/material.dart';

@immutable
class CategoryModel {
  final String title;
  final String imageUrl;
  final List<String> selections;

  const CategoryModel({
    required this.title,
    required this.imageUrl,
    required this.selections,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> map) {
    return CategoryModel(
      title: map['title'] as String,
      imageUrl: map['imageUrl'] as String,
      selections: map['selections'] is List<dynamic>
          ? (map['selections'] as List<dynamic>)
              .map((e) => e.toString())
              .toList()
          : [],
    );
  }
}
