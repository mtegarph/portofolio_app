import 'package:portofolio_app/features/home/domain/entities/rumah_entity.dart';

class RumahModel extends RumahEntity {
  RumahModel(
      {required this.nama,
      required this.gambar,
      required this.detail,
      required this.idRumah})
      : super(detail: detail, gambar: gambar, nama: nama, id: idRumah);
  factory RumahModel.fromJson(Map<String, dynamic> json) => RumahModel(
        detail: json['detail'] as String,
        gambar: json['gambar'] as String,
        nama: json['nama'] as String,
        idRumah: json['idRumah'] as String,
      );

  String nama;
  String gambar;
  String detail;
  String idRumah;
  Map<String, dynamic> toJson() => {
        'idRumah': idRumah,
        'detail': detail,
        'gambar': gambar,
        'nama': nama,
      };
}
