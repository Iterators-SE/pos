import '../../models/product.dart';

abstract class IInventoryDataSource {
  Future<bool> addProduct(
      {String productname,
      String description,
      bool taxable,
      String photoLink});
  Future<List<Product>> getProducts();
  Future<bool> deleteProduct({int productId});
  Future<Product> getProductDetails({int productId});
  // Future<Product> changeProductDetails({int productId })
}
