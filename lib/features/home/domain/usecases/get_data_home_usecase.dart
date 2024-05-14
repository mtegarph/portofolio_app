import 'package:dartz/dartz.dart';
import 'package:portofolio_app/core/error/failure.dart';
import 'package:portofolio_app/core/usecase/usecase.dart';
import 'package:portofolio_app/features/home/domain/entities/rumah_entity.dart';
import 'package:portofolio_app/features/home/domain/repositories/home_page_repositories.dart';

class GetDataHomeUseCase
    implements UseCase<Either<Failure, List<RumahEntity>>, void> {
  GetDataHomeUseCase({required this.homePageRepo});

  final HomePageRepo homePageRepo;
  @override
  Future<Either<Failure, List<RumahEntity>>> call({void params}) {
    // TODO: implement call
    return homePageRepo.getHomePageData();
  }
}
