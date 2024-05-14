part of 'set_rumah_bloc.dart';

sealed class SetRumahBlocEvent extends Equatable {
  const SetRumahBlocEvent();

  @override
  List<Object> get props => [];
}

class PostRumah extends SetRumahBlocEvent {
  const PostRumah({required this.params});

  final CreateParam params;
}

class UpdateRumah extends SetRumahBlocEvent {
  const UpdateRumah({required this.params});

  final RumahEntity params;
}
