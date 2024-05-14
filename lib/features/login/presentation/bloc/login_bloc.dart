import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:portofolio_app/core/parameter/parameter.dart';
import 'package:portofolio_app/features/login/domain/entities/login_entity.dart';
import 'package:portofolio_app/features/login/domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this.loginUseCase) : super(LoginInitial()) {
    on<PostLogin>(onPost);
  }
  final LoginUseCase loginUseCase;
  void onPost(PostLogin event, Emitter<LoginState> emit) async {
    emit(LoginPostLoading());
    final result = await loginUseCase.call(params: event.parameter);
    result.fold((l) => emit(LoginFailed(message: l.message)),
        (r) => emit(LoginSuccess(item: r)));
  }
}
