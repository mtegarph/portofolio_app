import 'package:flutter/cupertino.dart';
import 'package:portofolio_app/app/app.dart';
import 'package:portofolio_app/bootstrap.dart';
import 'package:portofolio_app/config/database/appwrite_config.dart';
import 'package:portofolio_app/dependency_injection.dart';

Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize dependencies
  await initializeDependencies(AppwriteConfig.client);

  // Start the app
  await bootstrap(() => const App());
}
