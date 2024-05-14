import 'package:dartz/dartz.dart';
import 'package:portofolio_app/core/error/failure.dart';
import 'package:portofolio_app/core/parameter/create_param.dart';
import 'package:portofolio_app/features/home/domain/entities/rumah_entity.dart';

abstract class HomePageRepo {
  Future<Either<Failure, List<RumahEntity>>> getHomePageData();
  Future<Either<Failure, String>> setRumahData(CreateParam params);
  Future<Either<Failure, String>> deleteRumahData(String id);
  Future<Either<Failure, String>> updateRumahData(RumahEntity params);
}
