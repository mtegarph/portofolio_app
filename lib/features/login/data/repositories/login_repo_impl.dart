import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:portofolio_app/core/error/exception.dart';
import 'package:portofolio_app/core/error/failure.dart';
import 'package:portofolio_app/core/parameter/parameter.dart';
import 'package:portofolio_app/features/login/data/datasources/local/shared_pref_login.dart';
import 'package:portofolio_app/features/login/data/datasources/remote/implementation/login_data_source_impl.dart';
import 'package:portofolio_app/features/login/domain/entities/login_entity.dart';
import 'package:portofolio_app/features/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl(
      {required this.loginDataSourceImpl,
      required this.sharedPrefLoginDataSource});

  final LoginDataSourceImpl loginDataSourceImpl;
  final SharedPrefLoginDataSource sharedPrefLoginDataSource;
  @override
  Future<Either<Failure, LoginEntity>> login(
    String email,
    String password,
  ) async {
    try {
      final result = await loginDataSourceImpl.login(email, password);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on SocketException {
      return const Left(ConnectionFailure('Failed To Connect To internet'));
    }
  }

  @override
  Future<Either<Failure, LoginEntity>> register(Parameter parameter) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> getLogin() async {
    try {
      final response = await sharedPrefLoginDataSource.getLogin();
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on SocketException {
      return const Left(ConnectionFailure('Failed To Connect To internet'));
    }
  }
}
