import '../../models/product.dart';
import 'inventory_datasource.dart';

class InventoryLocalDataSource implements IInventoryLocalDataSource {
  @override
  Future<void> cacheProduct(dynamic data) {
      // TODO: implement cacheProduct
      throw UnimplementedError();
    }
  
    @override
    Future<void> cacheProducts(dynamic data) {
      // TODO: implement cacheProducts
      throw UnimplementedError();
    }
  
    @override
    Future<Product> getProductDetails({int productId}) {
    // TODO: implement getProductDetails
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getProducts() {
    // TODO: implement getProducts
    throw UnimplementedError();
  }
}