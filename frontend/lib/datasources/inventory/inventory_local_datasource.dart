import '../../database/local/local_database.dart';
import 'inventory_datasource.dart';

class InventoryLocalDataSource implements IInventoryLocalDataSource {
  final AppDatabase local;
  InventoryLocalDataSource({this.local});
  @override
  Future<void> cacheProduct(dynamic data) {
      throw UnimplementedError();
    }
  
    @override
    Future<void> cacheProducts(dynamic data) {
      throw UnimplementedError();
    }
  
    @override
    Future<Product> getProductDetails({int productId}) {
      return local.getProduct(productId);
  }

  @override
  Future<List<Product>> getProducts() {
    return local.getProducts();
  }
}