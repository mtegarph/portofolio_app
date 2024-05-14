part of 'set_rumah_bloc.dart';

sealed class SetRumahBlocState extends Equatable {
  const SetRumahBlocState();

  @override
  List<Object> get props => [];
}

final class SetRumahBlocInitial extends SetRumahBlocState {}

class SetRumahLoading extends SetRumahBlocState {}

class SetRumahLoaded extends SetRumahBlocState {
  const SetRumahLoaded({required this.message});

  final String message;
}

class SetRumahFailed extends SetRumahBlocState {
  const SetRumahFailed({required this.message});

  final String message;
}

class UpdateRumahLoading extends SetRumahBlocState {}

class UpdateRumahLoaded extends SetRumahBlocState {
  const UpdateRumahLoaded({required this.message});

  final String message;
}

class UpdateRumahFailed extends SetRumahBlocState {
  const UpdateRumahFailed({required this.message});

  final String message;
}
