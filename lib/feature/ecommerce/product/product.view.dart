import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/shared.module.dart';
import '../ecommerce.controller.dart';
import 'product.argument.dart';

class ProductView extends ConsumerStatefulWidget {
  final ProductArgument arguments;
  const ProductView({required this.arguments, super.key});

  @override
  ConsumerState<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends ConsumerState<ProductView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String? selectedImageUrl;
  String? selectedSize;

  @override
  void initState() {
    selectedImageUrl = widget.arguments.product.imageUrls.first;
    selectedSize = widget.arguments.product.sizes?.first;
    super.initState();
  }

  void setSelectedImageUrl(String url) {
    setState(() {
      selectedImageUrl = url;
    });
  }

  // TODO: move to controller
  void setSelectedSize(String size) {
    setState(() {
      selectedSize = size;
    });
  }

  List<Widget> get sizeSelectionWidgets =>
      widget.arguments.product.sizes
          ?.map(
            (s) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                onTap: () {
                  setSelectedSize(s);
                },
                child: Container(
                  height: 42,
                  width: 38,
                  decoration: BoxDecoration(
                    color: widget.arguments.product.sizes?.first == s
                        ? Theme.of(context).colorScheme.secondary
                        : null,
                    border: Border.all(
                      color: Colors.grey[350]!,
                      width: 1.25,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      s,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: widget.arguments.product.sizes?.first == s
                              ? Colors.white
                              : null),
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList() ??
      [];

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
      actions: const [
        // CartAppBarAction(),
      ],
    );
  }

  Widget _buildBody() {
    List<Widget> imagePreviews = widget.arguments.product.imageUrls
        .map(
          (url) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () => setSelectedImageUrl(url),
              child: Container(
                height: 50,
                width: 50,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: selectedImageUrl == url
                      ? Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 1.75)
                      : null,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.network(
                  url,
                  loadingBuilder: (_, child, loadingProgress) =>
                      loadingProgress == null
                          ? child
                          : const Center(child: CircularProgressIndicator()),
                  errorBuilder: (_, error, stackTrace) => const Center(
                      child: CircularProgressIndicator(
                    color: Colors.deepOrange,
                  )),
                ),
              ),
            ),
          ),
        )
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * .35,
          color: Colors.grey,
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Image.network(
                  selectedImageUrl!,
                  fit: BoxFit.cover,
                  color: Colors.grey,
                  colorBlendMode: BlendMode.multiply,
                ),
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imagePreviews,
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.arguments.product.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  '\$${widget.arguments.product.cost}',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.arguments.product.description ??
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer quis purus laoreet, efficitur libero vel, feugiat ante. Vestibulum tempor, ligula.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(height: 1.5),
                ),
                const SizedBox(
                  height: 18,
                ),
                if (sizeSelectionWidgets.isNotEmpty) ...[
                  Text(
                    'Size',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: sizeSelectionWidgets,
                  ),
                ],
                const Spacer(),
                Center(
                  child: ObserverButton(
                    buttonType: ButtonType.outlinedButton,
                    onPressed: (observer) {
                      observer.setLoading();
                      // cart.add(
                      //   OrderItem(
                      //     product: widget.arguments.product,
                      //     selectedSize: selectedSize,
                      //   ),
                      // );
                      observer.setIdle();
                    },
                    width: double.infinity,
                    title: 'Add to Cart',
                    // color: ThemeColor.blue300,
                    alignment: CrossAxisAlignment.end,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
