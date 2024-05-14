import 'package:appwrite/appwrite.dart';
import 'package:portofolio_app/config/database/appwrite_config.dart';
import 'package:portofolio_app/core/error/exception.dart';
import 'package:portofolio_app/features/login/data/datasources/local/shared_pref_login.dart';
import 'package:portofolio_app/features/login/data/datasources/remote/abstract/login_data_source.dart';
import 'package:portofolio_app/features/login/data/models/login_model.dart';

class LoginDataSourceImpl implements LoginDataSourceAbstract {
  LoginDataSourceImpl({
    required this.client,
    required this.sharedPrefLoginDataSource,
  });

  final Client client;
  final SharedPrefLoginDataSource sharedPrefLoginDataSource;
  @override
  Future<LoginModel> login(String email, String password) async {
    final account = Account(client);
    try {
      await account.createEmailPasswordSession(
        email: email,
        password: password,
      );
      //final user = await account.get();
      // print(user);
      await sharedPrefLoginDataSource.saveUser(login: true);
      return LoginModel(
        email: '',
        password: '',
        name: '',
      );
    } on AppwriteException catch (e) {
      print('Login failed with error: $e'); // Log the error
      throw ServerException();
    }
  }
}
