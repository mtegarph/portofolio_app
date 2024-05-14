import 'package:dartz/dartz.dart';
import 'package:portofolio_app/core/error/exception.dart';
import 'package:portofolio_app/core/error/failure.dart';
import 'package:portofolio_app/core/parameter/create_param.dart';
import 'package:portofolio_app/features/home/data/datasources/remote/rumah_data_source.dart';
import 'package:portofolio_app/features/home/data/models/rumah_model.dart';
import 'package:portofolio_app/features/home/domain/entities/rumah_entity.dart';
import 'package:portofolio_app/features/home/domain/repositories/home_page_repositories.dart';

class RumahRepostoryImpl implements HomePageRepo {
  RumahRepostoryImpl({required this.rumahDataSource});

  final RumahDataSource rumahDataSource;
  @override
  Future<Either<Failure, List<RumahEntity>>> getHomePageData() async {
    try {
      final response = await rumahDataSource.getAllRumahData();
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> setRumahData(CreateParam params) async {
    try {
      RumahModel rumahModel = RumahModel(
        nama: params.nama,
        gambar: params.gambar,
        detail: params.detail,
        idRumah: '',
      );
      await rumahDataSource.createRumahData(rumahModel);
      return const Right('Data Berhasil Di input');
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> deleteRumahData(String id) async {
    // TODO: implement deleteRumahData
    try {
      await rumahDataSource.deleteDocument(id);
      return const Right('Data Berhasil Dihapus');
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> updateRumahData(RumahEntity params) async {
    try {
      final rumahModel = RumahModel(
        nama: params.nama,
        gambar: params.gambar,
        detail: params.detail,
        idRumah: params.id,
      );
      print('id Rumah : ${params.id}');
      print('nama Rumah : ${params.nama}');
      await rumahDataSource.updateDocument(rumahModel);
      return const Right('Data Berhasil Diupdate');
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
