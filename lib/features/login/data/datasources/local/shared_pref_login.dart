import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefLoginDataSource {
  final SharedPreferences sharedPreferences = GetIt.I<SharedPreferences>();

  Future<void> saveUser({required bool login}) async {
    await sharedPreferences.setBool('isLogin', login);
  }

  Future<bool> getLogin() async {
    return (await sharedPreferences.getBool('isLogin')) ?? false;
  }
}
