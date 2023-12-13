import 'package:fcar_lib/core/utility/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/base.controller.dart';
import '../../shared/dialog/dialog.dart';
import '../ecommerce.repository.dart';
import '../model/order_item.model.dart';

final cartController = AutoDisposeNotifierProvider<CartController, int>(() {
  return CartController();
});

class CartController extends BaseController<int> {
  late final EcommerceRepository _ecommerceRepository;
  @override
  int build() {
    ref.onDispose(() {});
    _ecommerceRepository = ref.read(ecommerceRepository);
    return 0;
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final List<OrderItemModel> itemsInCart = [];

  int get cartSize => state;

  double get totalCost =>
      itemsInCart.fold(0.0, (total, item) => total + item.product.cost);

  Future<void> getCart() async {
    try {
      itemsInCart.addAll(await _ecommerceRepository.getCart());
      state = itemsInCart.length;
    } catch (e, s) {
      logger.error('get cart', e: e, s: s);
      showErrorDialog(error: e);
      // ErrorTracking.recordError(e, s);
      itemsInCart.clear();
      state = 0;
    }
  }

  Future<void> addToCart({required OrderItemModel item}) async {
    try {
      await _ecommerceRepository.addToCart(item: item);

      // or return data from the backend or call getCart()
      itemsInCart.add(item);
      state = itemsInCart.length;
    } catch (e, s) {
      logger.error('add cart', e: e, s: s);
      showErrorDialog(error: e);
      // ErrorTracking.recordError(e, s);
    }
  }

  Future<void> removeFromCart({required OrderItemModel item}) async {
    try {
      await _ecommerceRepository.removeFromCart(item: item);

      // or return data from the backend or call getCart()
      itemsInCart.remove(item);
      state = itemsInCart.length;
    } catch (e, s) {
      logger.error('remove from cart', e: e, s: s);
      showErrorDialog(error: e);
      // ErrorTracking.recordError(e, s);
    }
  }

  Future<void> navigateTo() async {}
}
