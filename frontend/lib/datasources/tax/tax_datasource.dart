import '../../features/tax/models/new_tax.dart';

import '../../models/tax.dart';

abstract class ITaxDataSource {
  Future<List<Tax>> getTaxes();
  Future<Tax> getTaxDetails(int taxId);
  Future<Tax> getSelectedTax();
}

abstract class ITaxRemoteDataSource implements ITaxDataSource {
  Future<bool> addTax(NewTax newTax);
  Future<bool> deleteTax(Tax tax);
  Future<bool> editTax(Tax tax);
  Future<bool> selectTax(Tax tax);
}

abstract class ITaxLocalDataSource implements ITaxDataSource {
  Future<void> cacheSelectedTax(dynamic data);
  Future<void> cacheTaxes(dynamic data);
}
