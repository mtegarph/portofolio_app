import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:portofolio_app/features/home/domain/entities/rumah_entity.dart';
import 'package:portofolio_app/features/home/domain/usecases/delete_track_usecase.dart';
import 'package:portofolio_app/features/home/domain/usecases/get_data_home_usecase.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  final GetDataHomeUseCase getDataHomeUseCase;
  final DeleteTrackUseCase deleteTrackUseCase;
  HomepageBloc(
      {required this.getDataHomeUseCase, required this.deleteTrackUseCase})
      : super(HomepageInitial()) {
    on<GetDataHomeEvent>(_getDataHome);
    on<DeleteTrackEvent>(_deleteTrack);
  }
  void _getDataHome(GetDataHomeEvent event, Emitter<HomepageState> emit) async {
    emit(HomepageLoading());
    final result = await getDataHomeUseCase.call();
    result.fold(
      (failure) => emit(HomepageFailure(message: failure.message)),
      (rumahEntities) => emit(
        HomepageSuccess(rumahEntities: rumahEntities),
      ),
    );
  }

  void _deleteTrack(DeleteTrackEvent event, Emitter<HomepageState> emit) async {
    emit(DeleteLoading());
    final result = await deleteTrackUseCase.call(params: event.id);
    result.fold(
      (failure) => emit(DeleteFailure(message: failure.message)),
      (message) => emit(DeleteSuccess(message: message)),
    );
  }
}

class HomepageDataBloc extends Bloc<HomepageEvent, HomePageDataState> {
  HomepageDataBloc({required this.getDataHomeUseCase})
      : super(const HomePageDataState()) {
    on<ShowDelete>(_showDelete);
  }
  final GetDataHomeUseCase getDataHomeUseCase;

  void _showDelete(ShowDelete event, Emitter<HomePageDataState> emit) {
    emit(state.copyWith(showDelete: event.showDelete));
  }
}
