import 'package:equatable/equatable.dart';

//di class ini yang meng handle jika ada parameter di api untuk update data
class Parameter extends Equatable {
  final String? name;
  final String email;
  final String password;

  final String? noHp;

  const Parameter({
    required this.email,
    required this.password,
    this.noHp,
    this.name,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [name, password, noHp];
}
