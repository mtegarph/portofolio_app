import 'package:flutter_test/flutter_test.dart';
import 'package:portofolio_app/features/home/data/models/rumah_model.dart';
import 'package:portofolio_app/features/home/domain/entities/rumah_entity.dart';

void main() {
  final rumah = RumahModel(
    detail: 'Detail rumah',
    gambar: 'Gambar rumah',
    nama: 'Nama rumah',
    idRumah: 'ID rumah',
  );

  group('RumahModel', () {
    test('should be subclass of RumahEntity', () {
      expect(rumah, isA<RumahEntity>());
    });
    test('fromJson', () {
      final rumah = RumahModel.fromJson(const {
        'detail': 'Detail rumah',
        'gambar': 'Gambar rumah',
        'nama': 'Nama rumah',
        'idRumah': 'ID rumah',
      });

      expect(rumah.detail, 'Detail rumah');
      expect(rumah.gambar, 'Gambar rumah');
      expect(rumah.nama, 'Nama rumah');
      expect(rumah.idRumah, 'ID rumah');
    });

    test('toJson', () {
      final json = rumah.toJson();

      expect(json['detail'], 'Detail rumah');
      expect(json['gambar'], 'Gambar rumah');
      expect(json['nama'], 'Nama rumah');
      expect(json['idRumah'], 'ID rumah');
    });
  });
}
