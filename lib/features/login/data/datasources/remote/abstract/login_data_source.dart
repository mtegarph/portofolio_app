import 'package:portofolio_app/features/login/data/models/login_model.dart';

abstract class LoginDataSourceAbstract {
  Future<LoginModel> login(String email, String password);
}
