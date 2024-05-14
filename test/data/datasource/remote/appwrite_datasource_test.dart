import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:appwrite/appwrite.dart';
import 'package:mockito/mockito.dart';
import 'package:portofolio_app/app/app.dart';
import 'package:portofolio_app/config/database/appwrite_config.dart';
import 'package:portofolio_app/core/constant/constant.dart';
import 'package:portofolio_app/features/home/data/datasources/remote/rumah_data_source.dart';
import 'package:portofolio_app/features/home/data/models/rumah_model.dart';
import 'package:path_provider/path_provider.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late RumahDataSource dataSource;
  late MockClient mockClient;
  late MockDatabases mockDatabases;
  late MockAccount account;

  setUp(() {
    account = MockAccount();
    mockClient = MockClient();
    mockDatabases = MockDatabases();
    dataSource = MockRumahDataSource();
  });
  final rumahModel = [
    RumahModel(
      nama: 'Rumah Test',
      gambar: 'https://example.com/gambar.jpg',
      detail: 'Detail Rumah Test',
      idRumah: '1',
    ),
    RumahModel(
      nama: 'Rumah Test',
      gambar: 'https://example.com/gambar.jpg',
      detail: 'Detail Rumah Test',
      idRumah: '1',
    ),
  ];
  final data = RumahModel(
    nama: 'Rumah Test',
    gambar: 'https://example.com/gambar.jpg',
    detail: 'Detail Rumah Test',
    idRumah: '1',
  );
  group('RumahDataSource Tests', () {
    test('get all data', () {
      //arrange
      when(
        dataSource.getAllRumahData(),
      ).thenAnswer((realInvocation) async => rumahModel);

      //act
      final result = dataSource.getAllRumahData();

      //assert
      expect(result, isA<Future<List<RumahModel>>>());
    });
    test('get one data ', () {
      //arrange
      when(
        dataSource.getDocument('1'),
      ).thenAnswer((realInvocation) async => data);

      //act
      final result = dataSource.getDocument('1');

      //assert
      expect(result, isA<Future<RumahModel>>());
    });
    test('input one data ', () {
      //arrange
      when(
        dataSource.createRumahData(data),
      ).thenAnswer((realInvocation) async => data);

      //act
      final result = dataSource.createRumahData(data);

      //assert
      expect(result, isA<Future<void>>());
    });
    test('delete one data ', () {
      //arrange
      when(
        dataSource.deleteDocument('1'),
      ).thenAnswer((realInvocation) async => true);

      //act
      final result = dataSource.deleteDocument('1');

      //assert
      expect(result, isA<Future<bool>>());
    });
    test('update one data ', () {
      //arrange
      when(
        dataSource.updateDocument(data),
      ).thenAnswer((realInvocation) async => data);

      //act
      final result = dataSource.updateDocument(data);

      //assert
      expect(result, isA<Future<void>>());
    });
  });
}
