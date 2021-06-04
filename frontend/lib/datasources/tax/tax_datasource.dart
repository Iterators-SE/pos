import '../../features/tax/models/new_tax.dart';

import '../../models/tax.dart';

abstract class ITaxDataSource {
  Future<List<dynamic>> getTaxes();
  Future<dynamic> getTaxDetails(int taxId);
  Future<dynamic> getSelectedTax();
}

abstract class ITaxRemoteDataSource implements ITaxDataSource {
  Future<bool> addTax(NewTax newTax);
  Future<bool> deleteTax(Tax tax);
  Future<bool> editTax(Tax tax);
  Future<bool> selectTax(Tax tax);
}

abstract class ITaxLocalDataSource implements ITaxDataSource {
  Future<void> cacheTaxes(dynamic data);
}
