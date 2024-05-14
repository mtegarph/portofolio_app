import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:portofolio_app/core/parameter/create_param.dart';
import 'package:portofolio_app/features/home/domain/entities/rumah_entity.dart';
import 'package:portofolio_app/features/home/domain/usecases/set_rumah_usecase.dart';
import 'package:portofolio_app/features/home/domain/usecases/update_track_usecase.dart';

part 'set_rumah_event.dart';
part 'set_rumah_state.dart';

class SetRumahBlocBloc extends Bloc<SetRumahBlocEvent, SetRumahBlocState> {
  SetRumahBlocBloc({
    required this.setRumahUseCase,
    required this.updateTrackUseCase,
  }) : super(SetRumahBlocInitial()) {
    on<PostRumah>(onPost);
    on<UpdateRumah>(onUpdate);
  }
  final SetRumahUseCase setRumahUseCase;
  final UpdateTrackUseCase updateTrackUseCase;
  void onPost(PostRumah event, Emitter<SetRumahBlocState> emit) async {
    emit(SetRumahLoading());
    final result = await setRumahUseCase.call(params: event.params);
    result.fold(
      (l) => emit(SetRumahFailed(message: l.message)),
      (r) => emit(SetRumahLoaded(message: r)),
    );
  }

  void onUpdate(UpdateRumah event, Emitter<SetRumahBlocState> emit) async {
    emit(SetRumahLoading());
    final result = await updateTrackUseCase.call(params: event.params);
    result.fold(
      (l) => emit(SetRumahFailed(message: l.message)),
      (r) => emit(SetRumahLoaded(message: r)),
    );
  }
}
