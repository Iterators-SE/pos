import 'package:either_option/either_option.dart';
import 'package:frontend/datasources/profile/profile_datasource.dart';
import 'package:meta/meta.dart';

import '../../core/error/failure.dart';
import '../../core/network/network_info.dart';
import '../../datasources/profile/profile_local_datasource.dart';
import '../../datasources/profile/profile_remote_datasource.dart';
import '../../models/user_profile.dart';

abstract class IProfileRepository {
  final IProfileRemoteDataSource remote;
  final ProfileLocalDataSource local;
  final NetworkInfo network;

  IProfileRepository(
      {@required this.remote, @required this.local, @required this.network});

  Future<Either<Failure, UserProfile>> getProfileInfo();
  Future<Either<Failure, UserProfile>> updateProfileInfo(
      UserProfile userProfile);
}
