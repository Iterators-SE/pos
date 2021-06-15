import '../../database/local/local_database.dart';
import 'inventory_datasource.dart';

class InventoryLocalDataSource implements IInventoryLocalDataSource {
  final AppDatabase local;
  InventoryLocalDataSource({this.local});

  @override
  Future<void> cacheProducts(dynamic data) async {
    await data.map((product) {
      local.addProduct(Product(
          photoLink: product.photoLink,
          name: product.name,
          description: product.description,
          id: product.productid,
          taxable: product.taxable));
    });
  }

  @override
  Future<dynamic> getProductDetails({int productId}) async {
    return local.getProduct(productId);
  }

  @override
  Future<List<dynamic>> getProducts() async {
    return await local.getProducts();
  }
}
