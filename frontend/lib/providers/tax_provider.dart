import 'package:either_option/either_option.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../core/error/failure.dart';
import '../models/tax.dart';
import '../repositories/tax/tax_repository_implementation.dart';

class TaxProvider extends ChangeNotifier {
  Future<Either<Failure, List<Tax>>> getTaxes(BuildContext context) async {
    var provider = await Provider.of<TaxRepository>(context, listen: false);
    var data = await provider.getTaxes();
    return data;
  }

  Future<Either<Failure, bool>> selectTax(BuildContext context, Tax tax) async {
    var provider = await Provider.of<TaxRepository>(context, listen: false);
    var data = await provider.selectTax(tax);
    return data;
  }
}
