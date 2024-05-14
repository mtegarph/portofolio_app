part of 'get_login_bloc.dart';

sealed class GetLoginEvent extends Equatable {
  const GetLoginEvent();

  @override
  List<Object> get props => [];
}

class GetLogin extends GetLoginEvent {
  const GetLogin();
}
