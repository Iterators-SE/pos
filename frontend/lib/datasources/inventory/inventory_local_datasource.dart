import '../../database/local/local_database.dart';
import 'inventory_datasource.dart';

class InventoryLocalDataSource implements IInventoryLocalDataSource {
  final AppDatabase local;
  InventoryLocalDataSource({this.local});

  @override
  Future<void> cacheProducts(dynamic data)async {
    final List<Product> products = await data.map((product) {
      return Product(
        photoLink: product['photoLink'],
        name: product['name'],
        description: product['description'],
        id: product['productid'],
        taxable: product['taxable']
      );
    });
    await products.map(local.addProduct);
  }

  @override
  Future<Product> getProductDetails({int productId})async {
    return local.getProduct(productId);
  }

  @override
  Future<List<Product>> getProducts() async{
    return await local.getProducts();
  }
}
