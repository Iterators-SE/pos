// ignore: implementation_imports
import 'package:either_option/src/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';
import '../../core/network/network_info.dart';
import '../../datasources/profile/profile_local_datasource.dart';
import '../../datasources/profile/profile_remote_datasource.dart';
import '../../models/user_profile.dart';
import 'profile_repository.dart';

class ProfileRepository implements IProfileRepository {
  final ProfileRemoteDatasource remote;
  final ProfileLocalDataSource local;
  final NetworkInfo network;

  ProfileRepository({
    @required this.remote,
    @required this.local,
    @required this.network,
  });

  @override
  Future<Either<Failure, dynamic>> getProfileInfo() async {
    if (await network.isConnected()) {
      try {
        final data = await remote.getProfileInfo();
        // await print("Repo");
        // await print(data);
        // await local.cacheProfileInfo(data);
        return Right(data);
      } on OperationException catch (e) {
        return Left(OperationFailure(e.graphqlErrors.first.message));
      } on NoResultsFoundException {
        return Left(NoResultsFoundFailure());
      } on Exception {
        return Left(ServerFailure());
      } catch (e) {
        return Left(UnhandledFailure());
      }
    } else {
      try {
        final data = await local.getProfileInfo();
        return Right(data);
      } on CacheException {
        return Left(CacheFailure());
      } catch (e) {
        return Left(UnhandledFailure());
      }
    }
  }

  @override
  Future<Either<Failure, UserProfile>> updateProfileInfo(
      UserProfile userProfile) async {
    if (await network.isConnected()) {
      try {
        final data = await remote.updateProfileInfo(userProfile);
        // await print("Repo");
        // await print(data);
        // await local.cacheProfileInfo(data);
        return Right(data);
      } on OperationException catch (e) {
        return Left(OperationFailure(e.graphqlErrors.first.message));
      } on NoResultsFoundException {
        return Left(NoResultsFoundFailure());
      } on Exception {
        return Left(ServerFailure());
      } catch (e) {
        return Left(UnhandledFailure());
      }
    }

    return Left(UnhandledFailure());
  }
}
