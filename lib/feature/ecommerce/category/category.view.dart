import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/constant/asset.constant.dart';
import '../../shared/empty.view.dart';
import '../ecommerce.controller.dart';
import '../model/product.model.dart';
import '../product_title.widget.dart';
import 'category.argument.dart';

/// products.where((p) => p.category == category).toList();
class CategoryView extends ConsumerWidget {
  final CategoryArgument arguments;
  const CategoryView({
    required this.arguments,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryProducts = arguments.category.selections
        .map((s) => _card(
              context: context,
              productType: s,
              products: arguments.products
                  .where((p) => p.productType.toLowerCase() == s.toLowerCase())
                  .toList(),
            ))
        .toList();

    return WillPopScope(
      onWillPop: () => Future.value(true),
      child: Scaffold(
        key: GlobalKey<ScaffoldState>(),
        appBar: _buildAppBar(title: arguments.category.title),
        body: _buildBody(categoryProducts: categoryProducts),
      ),
    );
  }

  AppBar _buildAppBar({required String title}) {
    return AppBar(
      actions: const [
        //  CartAppBarAction(),
      ],
      centerTitle: true,
      title: Text(title),
    );
  }

  Widget _buildBody({required List<Widget> categoryProducts}) {
    return Column(
      children: [
        if (arguments.products.isNotEmpty)
          _buildList(categoryProducts: categoryProducts)
        else
          EmptyView(
            illustration: SvgPicture.asset(
              AssetConstant.noData,
              fit: BoxFit.fitHeight,
              alignment: Alignment.center,
              width: 200,
            ),
            title: 'Category is empty',
          ),
      ],
    );
  }

  Widget _buildList({required List<Widget> categoryProducts}) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        itemCount: arguments.products.length,
        itemBuilder: (_, index) => categoryProducts[index],
        separatorBuilder: (_, index) => const SizedBox(
          height: 16,
        ),
      ),
    );
  }

  Widget _card({
    required BuildContext context,
    required String productType,
    required List<ProductModel> products,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Text(
            productType,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        // const SizedBox(height: 8),
        ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          itemCount: products.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => ProductTile(product: products[index]),
          separatorBuilder: (_, index) => const SizedBox(width: 24),
        ),
      ],
    );
  }
}
