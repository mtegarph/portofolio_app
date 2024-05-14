import 'package:appwrite/models.dart' as models;
import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable{
  LoginEntity({required this.email, required this.password});

  final String email;
  final String password;
  
  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}
