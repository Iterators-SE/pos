import 'package:either_option/either_option.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import '../core/error/failure.dart';
import '../features/inventory/models/new_product.dart';
import '../models/product.dart';
import '../repositories/inventory/inventory_repository_implementation.dart';
import 'user_provider.dart';

class InventoryProvider extends ChangeNotifier {

  // final InventoryRepository inventoryRepository;

  // InventoryProvider({
  //   this.inventoryRepository
  // });

  // void setAuthenticated(BuildContext context) async {
  //       var token = Provider.of<UserProvider>(context, listen: false).token;

  //   inventoryRepository.remote.client = GraphQLClient(
  //     cache: GraphQLCache(),
  //     link: AuthLink(getToken: () => 'Bearer $token')
  //         .concat(HttpLink('http://iterators-pos.herokuapp.com/graphql')),
  //   );
  // }

  Future<Either<Failure, bool>> addProduct(
      BuildContext context, NewProduct product) async {
    var provider =
        await Provider.of<InventoryRepository>(context, listen: false);

    var data = await provider.addProduct(product: product);
    if (data.isRight) {
      return data;
    }
    return data;
  }

  Future<Either<Failure, List<Product>>> getProducts(
      BuildContext context) async {
    var provider =
        await Provider.of<InventoryRepository>(context, listen: false);
    var data = await provider.getProducts();
    if (data.isRight) {
      return data;
    }
    return data;
  }
}
