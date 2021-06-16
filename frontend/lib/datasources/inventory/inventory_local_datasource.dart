import '../../database/local/local_database.dart';
import 'inventory_datasource.dart';

class InventoryLocalDataSource implements IInventoryLocalDataSource {
  final AppDatabase local;
  InventoryLocalDataSource({this.local});

  @override
  Future<void> cacheProducts(dynamic data) async {
    print("PRODUCTS: $data");
    var result = await data.map((product) {
      List variants = product.variants;
      print("producting");
      print("Variant: ${product.variants}");
      local.addProduct(Product(
          photoLink: product.photoLink,
          name: product.name,
          description: product.description,
          id: product.id,
          taxable: product.isTaxable));
      variants.map((variant){
        local.addVariant(
          ProductVariant(
            variantid: variant.id, 
            variantname: variant.name, 
            price: variant.price, 
            productid: variant.productid, 
            quantity: variant.quantity)
        );
       });
    }
    );
    print(local.getProductVariants());
    print(result);
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
