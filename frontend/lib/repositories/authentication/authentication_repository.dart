import 'package:either_option/either_option.dart';

import '../../core/error/failure.dart';
import '../../models/user.dart';

abstract class IAuthenticationRepository {
  Future<Either<Failure, bool>> signup(
      {String name, String email, String password});
  Future<Either<Failure, User>> login({String email, String password});
  Future<Either<Failure, void>> logout();
}
