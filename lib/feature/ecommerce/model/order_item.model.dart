import 'product.model.dart';

class OrderItemModel {
  ProductModel product;
  String? selectedSize;
  String? selectedColor;

  OrderItemModel({
    required this.product,
    this.selectedSize,
    this.selectedColor,
  });
}
