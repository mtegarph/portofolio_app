import 'package:dartz/dartz.dart';
import 'package:portofolio_app/core/error/failure.dart';
import 'package:portofolio_app/core/usecase/usecase.dart';
import 'package:portofolio_app/features/login/domain/repositories/login_repository.dart';

class GetLoginUseCase implements UseCase<Either<Failure, bool>, void> {
  GetLoginUseCase({required this.homePageRepo});

  final LoginRepository homePageRepo;
  @override
  Future<Either<Failure, bool>> call({void params}) {
    return homePageRepo.getLogin();
  }
}
