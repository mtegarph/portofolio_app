part of 'get_login_bloc.dart';

sealed class GetLoginState extends Equatable {
  const GetLoginState();

  @override
  List<Object> get props => [];
}

final class GetLoginInitial extends GetLoginState {}

class GetLoginLoading extends GetLoginState {}

class GetLoginSuccess extends GetLoginState {
  final bool isLogin;
  const GetLoginSuccess({required this.isLogin});
}

class GetLoginFailure extends GetLoginState {
  final String message;
  const GetLoginFailure({required this.message});
}
