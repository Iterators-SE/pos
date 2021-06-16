import '../../database/local/local_database.dart';
import 'tax_datasource.dart';

class TaxLocalDataSource implements ITaxLocalDataSource {
  final AppDatabase local;
  TaxLocalDataSource({this.local});
  @override
  Future<void> cacheTaxes(dynamic data) async{
      final taxes = await data.map((tax) {
        local.addTax(Taxe(
          id: tax.id,
          name: tax.name,
          isSelected: tax.isSelected,
          percentage: tax.percentage
        ));
      });
      print(taxes);
    }
  
    @override
    Future<Taxe> getSelectedTax() async{
      return await local.getSelectedTax();
    }
  
    @override
    Future<Taxe> getTaxDetails(int taxId)async {
      return await local.getTaxDetails(taxId);
  }

  @override
  Future<List<Taxe>> getTaxes() async{
    return await local.getTaxes();
  }
  
}