import 'package:appwrite/appwrite.dart';
import 'package:get_it/get_it.dart';

import 'package:http/http.dart' as http;
import 'package:portofolio_app/features/home/data/datasources/remote/rumah_data_source.dart';
import 'package:portofolio_app/features/home/data/repositories/rumah_rep_impl.dart';
import 'package:portofolio_app/features/home/domain/repositories/home_page_repositories.dart';
import 'package:portofolio_app/features/home/domain/usecases/delete_track_usecase.dart';
import 'package:portofolio_app/features/home/domain/usecases/get_data_home_usecase.dart';
import 'package:portofolio_app/features/home/domain/usecases/set_rumah_usecase.dart';
import 'package:portofolio_app/features/home/domain/usecases/update_track_usecase.dart';
import 'package:portofolio_app/features/home/presentation/bloc/homepage_bloc.dart';
import 'package:portofolio_app/features/home/presentation/bloc/set_rumah_bloc/set_rumah_bloc.dart';
import 'package:portofolio_app/features/login/data/datasources/local/shared_pref_login.dart';
import 'package:portofolio_app/features/login/data/datasources/remote/abstract/login_data_source.dart';
import 'package:portofolio_app/features/login/data/datasources/remote/implementation/login_data_source_impl.dart';
import 'package:portofolio_app/features/login/data/repositories/login_repo_impl.dart';
import 'package:portofolio_app/features/login/domain/repositories/login_repository.dart';
import 'package:portofolio_app/features/login/domain/usecases/get_login_usecase.dart';
import 'package:portofolio_app/features/login/domain/usecases/login_usecase.dart';
import 'package:portofolio_app/features/login/presentation/bloc/get_login_bloc/get_login_bloc.dart';
import 'package:portofolio_app/features/login/presentation/bloc/login_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies(Client client) async {
// //dio
//   sl.registerSingleton<Dio>(Dio());
  //sharedpref
  final sharedPreferences = await SharedPreferences.getInstance();

  sl
    ..registerSingleton<SharedPreferences>(sharedPreferences)
    //http
    ..registerLazySingleton(http.Client.new)
    //data source
    ..registerLazySingleton<SharedPrefLoginDataSource>(
      () => SharedPrefLoginDataSource(),
    )
    ..registerLazySingleton<LoginDataSourceImpl>(
      () => LoginDataSourceImpl(
        client: client,
        sharedPrefLoginDataSource: sl(),
      ),
    )
    ..registerSingleton<RumahDataSource>(RumahDataSource())

    //repository
    ..registerSingleton<LoginRepository>(
      LoginRepositoryImpl(
        loginDataSourceImpl: sl(),
        sharedPrefLoginDataSource: sl(),
      ),
    )
    ..registerSingleton<HomePageRepo>(RumahRepostoryImpl(rumahDataSource: sl()))

//use case
    ..registerSingleton<LoginUseCase>(LoginUseCase(homePageRepo: sl()))
    ..registerSingleton<SetRumahUseCase>(SetRumahUseCase(homePageRepo: sl()))
    ..registerSingleton<GetDataHomeUseCase>(
      GetDataHomeUseCase(homePageRepo: sl()),
    )
    ..registerSingleton<GetLoginUseCase>(GetLoginUseCase(homePageRepo: sl()))
    ..registerSingleton<DeleteTrackUseCase>(
      DeleteTrackUseCase(homePageRepo: sl()),
    )
    ..registerSingleton<UpdateTrackUseCase>(
      UpdateTrackUseCase(homePageRepo: sl()),
    )

    //bloc
    ..registerFactory<LoginBloc>(() => LoginBloc(sl()))
    ..registerFactory<SetRumahBlocBloc>(
        () => SetRumahBlocBloc(setRumahUseCase: sl(), updateTrackUseCase: sl()))
    ..registerFactory<HomepageBloc>(
      () => HomepageBloc(
        getDataHomeUseCase: sl(),
        deleteTrackUseCase: sl(),
      ),
    )
    ..registerFactory<GetLoginBloc>(
      () => GetLoginBloc(getLoginUseCase: sl()),
    )
    ..registerFactory<HomepageDataBloc>(
      () => HomepageDataBloc(getDataHomeUseCase: sl()),
    );
}
