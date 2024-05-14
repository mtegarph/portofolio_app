import 'package:appwrite/models.dart' as models;
import 'package:portofolio_app/features/login/domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  LoginModel({
    required this.email,
    required this.password,
    this.name,
  }) : super(email: email, password: password);

  final String email;
  final String password;
  final String? name;
}
