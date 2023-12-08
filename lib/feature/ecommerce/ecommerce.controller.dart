import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/base.controller.dart';
import '../shared/dialog/dialog.dart';
import 'ecommerce.repository.dart';
import 'model/category.model.dart';
import 'model/order_item.model.dart';
import 'model/product.model.dart';
import 'product_title.widget.dart';

final ecommerceController =
    AutoDisposeNotifierProvider<EcommerceController, bool>(() {
  return EcommerceController();
});

class EcommerceController extends BaseController<bool> {
  late final EcommerceRepository _ecommerceRepository;
  @override
  bool build() {
    ref.onDispose(() {});
    _ecommerceRepository = ref.read(ecommerceRepository);
    getCategories().then(
        (value) => ref.read(ecommerceController.notifier).setCategories(value));
    return false;
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  String _searchString = '';
  final _searchResultTiles = <Widget>[];
  final _categories = <CategoryModel>[];
  final List<OrderItemModel> _itemsInCart = [];

  String get searchString => _searchString;
  List<Widget> get searchResultTiles => _searchResultTiles;
  List<CategoryModel> get categories => _categories;
  List<OrderItemModel> get itemsInCart => _itemsInCart;

  void setSearchString(String value) {
    _searchString = value;
    toggleState();
  }

  void setSearchResultTiles(List<Widget> value) {
    _searchResultTiles.addAll(value);
    toggleState();
  }

  void setCategories(List<CategoryModel> value) {
    _categories.addAll(value);
    toggleState();
  }

  void onChanged(String value) {
    if (_searchString != value) {
      _searchString = value;
      getProducts(productName: searchString.toLowerCase()).then((value) {
        setSearchResultTiles(
            value.map((p) => ProductTile(product: p)).toList());
      });
    }
  }

  Future<void> getCart() async {
    try {
      _itemsInCart.addAll(await _ecommerceRepository.getCart());
    } catch (e) {
      showErrorDialog(error: e);
      // ErrorTracking.recordError(e, s);
      _itemsInCart.clear();
    }
  }

  Future<List<CategoryModel>> getCategories({String? categoryName}) async {
    try {
      return _ecommerceRepository.getCategories(categoryName: categoryName);
    } catch (e) {
      showErrorDialog(title: 'Error', error: e);
      return [];
    }
  }

  Future<List<ProductModel>> getProducts({String? productName}) async {
    try {
      return _ecommerceRepository.getProducts(productName: productName);
    } catch (e) {
      showErrorDialog(title: 'Error', error: e);
      return [];
    }
  }

  Future<void> navigateTo() async {}
}
