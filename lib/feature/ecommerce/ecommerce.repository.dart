import 'dart:convert';

import 'package:fcar_lib/core/datasource/network/deserialize.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      fromMap: (e, {callback}) => CategoryModel.fromMap(e),
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
      fromMap: (e, {callback}) => ProductModel.fromMap(e),
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
