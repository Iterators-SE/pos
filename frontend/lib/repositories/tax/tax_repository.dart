import 'package:either_option/either_option.dart';
import 'package:meta/meta.dart';

import '../../core/error/failure.dart';
import '../../core/network/network_info.dart';
import '../../datasources/tax/tax_datasource.dart';
import '../../features/tax/models/new_tax.dart';
import '../../models/tax.dart';

abstract class ITaxRepository {
  final ITaxRemoteDataSource remote;
  final ITaxLocalDataSource local;
  final NetworkInfo network;

  const ITaxRepository({
    @required this.remote,
    @required this.local,
    @required this.network
  });

  Future<Either<Failure, List<Tax>>> getTaxes();
  Future<Either<Failure, Tax>> getTaxDetails(int taxId);
  Future<Either<Failure, Tax>> getSelectedTax();

  Future<Either<Failure, bool>> addTax(NewTax newTax);
  Future<Either<Failure, bool>> deleteTax(Tax tax);
  Future<Either<Failure, bool>> editTax(Tax tax);
  Future<Either<Failure, bool>> selectTax(Tax tax);

}
