import 'package:dartz/dartz.dart';
import 'package:portofolio_app/core/error/failure.dart';
import 'package:portofolio_app/core/parameter/parameter.dart';
import 'package:portofolio_app/core/usecase/usecase.dart';
import 'package:portofolio_app/features/login/domain/entities/login_entity.dart';
import 'package:portofolio_app/features/login/domain/repositories/login_repository.dart';

class LoginUseCase implements UseCase<Either<Failure, LoginEntity>, Parameter> {
  LoginUseCase({required this.homePageRepo});

  final LoginRepository homePageRepo;
  @override
  Future<Either<Failure, LoginEntity>> call({Parameter? params}) {
    return homePageRepo.login(params!.email, params.password);
  }
}
