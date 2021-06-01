import '../../database/local/local_database.dart';
import 'inventory_datasource.dart';

class InventoryLocalDataSource implements IInventoryLocalDataSource {
  final AppDatabase local;
  InventoryLocalDataSource({this.local});

  @override
  Future<void> cacheProducts(dynamic data)async {
    print(data);
    final List<Product> products = await data.map((product) {
      return Product(
        photoLink: data['photoLink'],
        name: data['name'],
        description: data['description'],
        id: data['productid'],
        taxable: data['taxable']
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
