import 'package:either_option/either_option.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';
import 'package:provider/provider.dart';

import '../core/error/failure.dart';
import '../models/tax.dart';
import '../repositories/tax/tax_repository_implementation.dart';
import 'user_provider.dart';

class TaxProvider extends ChangeNotifier {
  Future<Either<Failure, List<Tax>>> getTaxes(BuildContext context) async {
    var provider = await Provider.of<TaxRepository>(context, listen: false);
    var token = Provider.of<UserProvider>(context, listen: false).token;

    provider.remote.client = GraphQLClient(
      cache: GraphQLCache(),
      link: AuthLink(getToken: () => 'Bearer $token')
          .concat(HttpLink('http://iterators-pos.herokuapp.com/graphql')),
    );

    var data = await provider.getTaxes();
    if (data.isRight) {
      return data;
    }
    return data;
  }

  Future<Either<Failure, bool>> selectTax(BuildContext context, Tax tax) async {
    var provider = await Provider.of<TaxRepository>(context, listen: false);
    var token = Provider.of<UserProvider>(context, listen: false).token;

    provider.remote.client = GraphQLClient(
      cache: GraphQLCache(),
      link: AuthLink(getToken: () => 'Bearer $token')
          .concat(HttpLink('http://iterators-pos.herokuapp.com/graphql')),
    );

    var data = await provider.selectTax(tax);
    if (data.isRight) {
      notifyListeners();
      return data;
    }
    return data;
  }
}
