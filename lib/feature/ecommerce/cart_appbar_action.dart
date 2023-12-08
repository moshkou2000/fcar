import 'package:fcar_lib/core/service/navigation/navigation.dart';
import 'package:flutter/material.dart';

import '../../core/service/navigation/navigation_route.dart';
import 'model/order_item.model.dart';

class CartAppBarAction extends StatelessWidget {
  final List<OrderItemModel> itemsInCart;
  const CartAppBarAction({required this.itemsInCart, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(
            Icons.shopping_cart,
          ),
          if (itemsInCart.isNotEmpty)
            Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                ),
                child: Center(
                  child: Container(
                    height: 12,
                    width: 12,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: Center(
                      child: Text(
                        itemsInCart.length.toString(),
                        style: const TextStyle(
                          fontSize: 8,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      onPressed: () => Navigation.navigateTo(NavigationRoute.cartRoute),
    );
  }
}
