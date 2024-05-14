import 'package:appwrite/appwrite.dart';
import 'package:portofolio_app/config/database/appwrite_config.dart';
import 'package:portofolio_app/core/constant/constant.dart';
import 'package:portofolio_app/core/error/exception.dart';
import 'package:portofolio_app/features/home/data/models/rumah_model.dart';
import 'package:uuid/uuid.dart';

class RumahDataSource {
  Future<void> createRumahData(RumahModel params) async {
    var uid = Uuid().v4();
    try {
      RumahModel rumahModel = params..idRumah = uid;

      await Databases(AppwriteConfig.client).createDocument(
        databaseId: Appwriteconstans.dbID,
        collectionId: Appwriteconstans.collectionID,
        documentId: uid,
        data: rumahModel.toJson(),
      );
    } on AppwriteException catch (e) {
      print('Create failed with error: $e');
      throw ServerException();
    }
  }

  Future<List<RumahModel>> getAllRumahData() async {
    try {
      final result = await Databases(AppwriteConfig.client).listDocuments(
        databaseId: Appwriteconstans.dbID,
        collectionId: Appwriteconstans.collectionID,
      );
      return result.documents
          .map((doc) => RumahModel.fromJson(doc.data))
          .toList();
    } on AppwriteException catch (e) {
      print('Get all documents failed with error: $e');
      throw ServerException();
    }
  }

  Future<RumahModel> getDocument(String documentId) async {
    try {
      final result = await Databases(AppwriteConfig.client).getDocument(
        databaseId: Appwriteconstans.dbID,
        collectionId: Appwriteconstans.collectionID,
        documentId: documentId,
      );
      return RumahModel.fromJson(result.data);
    } on AppwriteException catch (e) {
      print('Get document failed with error: $e');
      throw ServerException();
    }
  }

  Future<bool> deleteDocument(String documentId) async {
    try {
      await Databases(AppwriteConfig.client).deleteDocument(
        databaseId: Appwriteconstans.dbID,
        collectionId: Appwriteconstans.collectionID,
        documentId: documentId,
      );
      return true;
    } on AppwriteException catch (e) {
      print('Get document failed with error: $e');
      throw ServerException();
    }
  }

  Future<void> updateDocument(RumahModel params) async {
    try {
      await Databases(AppwriteConfig.client).updateDocument(
        databaseId: Appwriteconstans.dbID,
        collectionId: Appwriteconstans.collectionID,
        documentId: params.idRumah,
        data: params.toJson(),
      );
      print(params.idRumah);
    } on AppwriteException catch (e) {
      print('Update failed with error: $e');
      throw ServerException();
    }
  }
}
