import 'package:fcar_lib/core/service/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/service/navigation/navigation_route.dart';
import 'cart_appbar_action.dart';
import 'category/category.argument.dart';
import 'ecommerce.controller.dart';
import 'model/category.model.dart';
import 'model/product.model.dart';

import '../shared/field/search_bar.dart' as widget;

class EcommerceView extends ConsumerStatefulWidget {
  const EcommerceView({super.key});

  @override
  ConsumerState<EcommerceView> createState() => _EcommerceViewState();
}

class _EcommerceViewState extends ConsumerState<EcommerceView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final _ = ref.watch(ecommerceController);

    return PopScope(
      canPop: true,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: widget.SearchBar(
        onChanged: ref.read(ecommerceController.notifier).onChanged,
      ),
      actions: [
        CartAppBarAction(
            itemsInCart: ref.read(ecommerceController.notifier).itemsInCart),
      ],
    );
  }

  Widget _buildBody() {
    return ref.read(ecommerceController.notifier).searchString.isNotEmpty
        ? GridView.count(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            crossAxisCount: 2,
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
            childAspectRatio: .78,
            children: ref.read(ecommerceController.notifier).searchResultTiles,
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Shop by Category',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                _buildList(
                    items: ref.read(ecommerceController.notifier).categories),
                const SizedBox(height: 16),
              ],
            ),
          );
  }

  Widget _buildList({required List<CategoryModel> items}) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        itemCount: items.length,
        itemBuilder: (_, index) => _card(
          context: context,
          category: items[index],
          products: [],
        ),
        separatorBuilder: (_, index) => const SizedBox(height: 8),
      ),
    );
  }

  Widget _card({
    required BuildContext context,
    required CategoryModel category,
    required List<ProductModel> products,
  }) {
    return InkWell(
      onTap: () => Navigation.navigateTo(
        NavigationRoute.categoryRoute,
        arguments: CategoryArgument(category: category, products: products),
      ),
      child: Container(
        height: 200,
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              category.imageUrl,
              loadingBuilder: (_, child, loadingProgress) =>
                  loadingProgress == null
                      ? child
                      : const Center(child: CircularProgressIndicator()),
              errorBuilder: (_, error, stackTrace) => const Center(
                  child: CircularProgressIndicator(
                color: Colors.deepOrange,
              )),
              color: Colors.grey,
              colorBlendMode: BlendMode.darken,
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                category.title.toUpperCase(),
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
