import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:portofolio_app/features/login/domain/usecases/get_login_usecase.dart';

part 'get_login_event.dart';
part 'get_login_state.dart';

class GetLoginBloc extends Bloc<GetLoginEvent, GetLoginState> {
  final GetLoginUseCase getLoginUseCase;
  GetLoginBloc({required this.getLoginUseCase}) : super(GetLoginInitial()) {
    on<GetLogin>(getLogin);
  }
  void getLogin(GetLogin event, Emitter<GetLoginState> emit) async {
    emit(GetLoginLoading());
    final result = await getLoginUseCase.call();
    result.fold(
      (failure) => emit(GetLoginFailure(message: failure.message)),
      (success) => emit(GetLoginSuccess(isLogin: success)),
    );
  }
}
