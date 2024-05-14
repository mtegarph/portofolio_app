import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:mockito/annotations.dart';
import 'package:portofolio_app/config/database/appwrite_config.dart';
import 'package:portofolio_app/features/home/data/datasources/remote/rumah_data_source.dart';
import 'package:portofolio_app/features/home/domain/repositories/home_page_repositories.dart';
import 'package:portofolio_app/features/home/domain/usecases/delete_track_usecase.dart';
import 'package:portofolio_app/features/home/domain/usecases/get_data_home_usecase.dart';
import 'package:portofolio_app/features/home/domain/usecases/set_rumah_usecase.dart';
import 'package:portofolio_app/features/home/domain/usecases/update_track_usecase.dart';

@GenerateMocks(
  [
    // TODO: Add mocks here
    RumahDataSource,
    HomePageRepo,
    DeleteTrackUseCase,
    GetDataHomeUseCase,
    SetRumahUseCase,
    UpdateTrackUseCase,
    Account,
    Client,
    Databases,
    Document
  ],
  customMocks: [
    // MockSpec<AppwriteConfig>(
    //   as: #AppwriteConfig.client,
    // ),
  ],
)
void main() {}
