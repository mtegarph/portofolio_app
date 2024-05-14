import 'package:equatable/equatable.dart';

class CreateParam extends Equatable {
  const CreateParam({
    required this.nama,
    required this.gambar,
    required this.detail,
    this.price,
    this.type,
  });

  final String nama;
  final String gambar;
  final String detail;
  final String? price;
  final String? type;

  @override
  List<Object?> get props => [nama, gambar, detail, price, type];
}
