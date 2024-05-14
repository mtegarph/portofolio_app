part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginPostLoading extends LoginState {}

class LoginSuccess extends LoginState {

  const LoginSuccess({required this.item});
  final LoginEntity item;
  @override
  List<Object> get props => [item];
}

class LoginFailed extends LoginState {

  const LoginFailed({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
