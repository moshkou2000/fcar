import 'dart:convert';

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

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
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

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
