import '../../models/tax.dart';

import 'tax_datasource.dart';

class TaxLocalDataSource implements ITaxLocalDataSource {
  @override
  Future<void> cacheTaxes(dynamic data) {
      // TODO: implement cacheProduct
      throw UnimplementedError();
    }
  
    @override
    Future<void> cacheSelectedTax(dynamic data) {
      // TODO: implement cacheSelectedTax
      throw UnimplementedError();
    }
  
    @override
    Future<Tax> getSelectedTax() {
      // TODO: implement getSelectedTax
      throw UnimplementedError();
    }
  
    @override
    Future<Tax> getTaxDetails(int taxId) {
    // TODO: implement getTaxDetails
    throw UnimplementedError();
  }

  @override
  Future<List<Tax>> getTaxes() {
    // TODO: implement getTaxes
    throw UnimplementedError();
  }
  
}