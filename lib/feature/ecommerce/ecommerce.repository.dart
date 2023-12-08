import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fcar_lib/core/datasource/network/deserialize.dart';

import 'model/category.model.dart';
import 'model/order_item.model.dart';
import 'model/product.model.dart';

final ecommerceRepository = Provider((ref) => EcommerceRepository());

class EcommerceRepository {
  Future<List<CategoryModel>> getCategories({String? categoryName}) async {
    // TODO: this is a mock
    //  implement yourown code
    //  use the repository network or lokal db
    final mock = await rootBundle.loadString('asset/mock/category.json');
    final dynamic json = jsonDecode(mock);
    return Deserialize<CategoryModel>(
      json,
      fromJson: (e, {callback}) => CategoryModel.fromJson(e),
    ).items;
  }

  Future<List<ProductModel>> getProducts({String? productName}) async {
    // TODO: this is a mock
    //  implement yourown code
    //  use the repository network or lokal db
    final mock = await rootBundle.loadString('asset/mock/products.json');
    final dynamic json = jsonDecode(mock);
    return Deserialize<ProductModel>(
      json,
      fromJson: (e, {callback}) => ProductModel.fromJson(e),
    ).items;
  }

  Future<List<OrderItemModel>> getCart() async {
    // TODO: use the repository
    //  network or lokal db
    return [];
  }

  Future<void> addToCart({required OrderItemModel item}) async {
    // TODO: use the repository
    //  network or lokal db
  }

  Future<void> removeFromCart({required OrderItemModel item}) async {
    // TODO: use the repository
    //  network or lokal db
  }
}
