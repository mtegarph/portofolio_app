import 'package:dartz/dartz.dart';
import 'package:portofolio_app/core/error/failure.dart';
import 'package:portofolio_app/core/parameter/create_param.dart';
import 'package:portofolio_app/core/usecase/usecase.dart';
import 'package:portofolio_app/features/home/domain/entities/rumah_entity.dart';
import 'package:portofolio_app/features/home/domain/repositories/home_page_repositories.dart';

class SetRumahUseCase
    implements UseCase<Either<Failure, String>, CreateParam> {
  SetRumahUseCase({required this.homePageRepo});

  final HomePageRepo homePageRepo;
  @override
  Future<Either<Failure, String>> call({CreateParam? params}) {
    return homePageRepo.setRumahData(params!);
  }
}
