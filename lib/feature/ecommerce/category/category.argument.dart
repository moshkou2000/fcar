import '../model/category.model.dart';
import '../model/product.model.dart';

class CategoryArgument {
  final CategoryModel category;
  final List<ProductModel> products;

  CategoryArgument({required this.category, required this.products});
}
