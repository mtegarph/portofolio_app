// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class RumahEntity extends Equatable {
  const RumahEntity({
    required this.nama,
    required this.gambar,
    required this.detail,
    required this.id,
  });

  final String nama;
  final String gambar;
  final String detail;
  final String id;
  @override
  List<Object?> get props => [nama, gambar, detail, id];
}
