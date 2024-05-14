part of 'homepage_bloc.dart';

abstract class HomepageEvent extends Equatable {
  const HomepageEvent();

  @override
  List<Object> get props => [];
}

class GetDataHomeEvent extends HomepageEvent {
  @override
  List<Object> get props => [];
}

class ShowDelete extends HomepageEvent {
  final bool showDelete;
  const ShowDelete({required this.showDelete});
  @override
  List<Object> get props => [showDelete];
}

class DeleteTrackEvent extends HomepageEvent {
  final String id;
  const DeleteTrackEvent({required this.id});
  @override
  List<Object> get props => [id];
}
