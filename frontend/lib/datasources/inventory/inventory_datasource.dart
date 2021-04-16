import '../../models/product.dart';

abstract class IInventoryDataSource {
  Future<bool> addProduct(
    {String productName,
    String description, 
    bool isTaxable, 
    String photoLink
    }
  );
  Future<List<Product>> getProducts();
  Future<bool> deleteProduct({int productId});
  Future<Product> getProductDetails({int productId});
  Future<bool> changeProductDetails(
    {int productId,
    String productName, 
    String description, 
    bool isTaxable, 
    String photoLink}
  );
}
