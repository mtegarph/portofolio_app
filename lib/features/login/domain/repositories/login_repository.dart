import 'package:dartz/dartz.dart';
import 'package:portofolio_app/core/error/failure.dart';
import 'package:portofolio_app/core/parameter/parameter.dart';
import 'package:portofolio_app/features/login/domain/entities/login_entity.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginEntity>> login(String email, String password);
  Future<Either<Failure, LoginEntity>> register(Parameter parameter);
  Future<Either<Failure, bool>> getLogin();
}
