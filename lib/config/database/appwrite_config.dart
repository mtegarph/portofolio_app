// appwrite_config.dart
import 'package:appwrite/appwrite.dart';

class AppwriteConfig {
  static final Client client = Client()
    ..setEndpoint('https://cloud.appwrite.io/v1')
    ..setProject('660518f69d2bf201279b')
    ..setSelfSigned(status: true);
}
