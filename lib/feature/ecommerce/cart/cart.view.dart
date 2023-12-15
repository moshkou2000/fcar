import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/constant/asset.constant.dart';
import '../../shared/button/button.dart';
import '../../shared/button/button.enum.dart';
import '../../shared/empty.view.dart';
import '../../shared/image/image.widget.dart';
import '../model/order_item.model.dart';
import 'cart.controller.dart';

class CartView extends ConsumerStatefulWidget {
  const CartView({super.key});

  @override
  ConsumerState<CartView> createState() => _CartViewState();
}

class _CartViewState extends ConsumerState<CartView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final cartSize = ref.watch(cartController);

    return PopScope(
      canPop: true,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: _buildAppBar(title: '$cartSize items'),
        body: _buildBody(cartSize: cartSize),
        bottomNavigationBar: _bottomNavigationAppBar(),
      ),
    );
  }

  AppBar _buildAppBar({required String title}) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Column(
        children: [
          const Text('Cart'),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBody({required int cartSize}) {
    final items = ref.read(cartController.notifier).itemsInCart;

    return Column(
      children: [
        if (cartSize > 0)
          Expanded(
            child: _buildList(items: items),
          )
        else
          EmptyView(
            illustration: SvgPicture.asset(
              AssetConstant.noData,
              fit: BoxFit.fitHeight,
              alignment: Alignment.center,
              width: 200,
            ),
            title: 'Your cart is empty',
          )
      ],
    );
  }

  Widget _buildList({required List<OrderItemModel> items}) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      itemCount: items.length,
      itemBuilder: (_, index) => _buildItem(item: items[index]),
      separatorBuilder: (_, index) => const SizedBox(
        height: 16,
      ),
    );
  }

  Widget _buildItem({required OrderItemModel item}) {
    return Row(
      children: [
        SizedBox(
          width: 125,
          child: ImageWidget(
            url: item.product.imageUrls.first,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.product.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                '\$${item.product.cost}',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () =>
              ref.read(cartController.notifier).removeFromCart(item: item),
          color: Colors.red,
        )
      ],
    );
  }

  Widget _bottomNavigationAppBar() {
    return BottomAppBar(
      height: 60,
      elevation: 0,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      // color: ThemeColor.navigationBarColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                '\$${ref.read(cartController.notifier).totalCost.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
          ObserverButton(
            buttonType: ButtonType.outlinedButton,
            onPressed: (observer) {
              observer.setLoading();
            },
            width: double.infinity,
            title: 'Check Out',
            // color: ThemeColor.blue300,
            alignment: CrossAxisAlignment.end,
          ),
        ],
      ),
    );
  }
}
