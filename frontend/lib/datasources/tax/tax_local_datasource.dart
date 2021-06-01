import '../../database/local/local_database.dart';
import 'tax_datasource.dart';

class TaxLocalDataSource implements ITaxLocalDataSource {
  final AppDatabase local;
  TaxLocalDataSource({this.local});
  @override
  Future<void> cacheTaxes(dynamic data) async{
      final List<Tax> taxes = await data.map((tax) {
        return Tax(
          id: tax['id'],
          name: tax['name'],
          isSelected: tax['isSelected'],
          perccentage: tax['percentage']
        );
      });
      await taxes.map(local.addTax);
    }
  
    @override
    Future<Tax> getSelectedTax() async{
      return await local.getSelectedTax();
    }
  
    @override
    Future<Tax> getTaxDetails(int taxId)async {
      return await local.getTaxDetails(taxId);
  }

  @override
  Future<List<Tax>> getTaxes() async{
    return await local.getTaxes();
  }
  
}