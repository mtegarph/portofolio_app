part of 'homepage_bloc.dart';

enum HomepageStatus { initial, loading, success, failure }

abstract class HomepageState extends Equatable {
  const HomepageState();

  @override
  List<Object> get props => [];
}

class HomepageInitial extends HomepageState {}

class HomepageLoading extends HomepageState {}

class HomepageSuccess extends HomepageState {
  final List<RumahEntity> rumahEntities;
  const HomepageSuccess({required this.rumahEntities});
}

class HomepageFailure extends HomepageState {
  final String message;
  const HomepageFailure({required this.message});
}

class DeleteLoading extends HomepageState {}

class DeleteSuccess extends HomepageState {
  final String message;
  const DeleteSuccess({required this.message});
}

class DeleteFailure extends HomepageState {
  final String message;
  const DeleteFailure({required this.message});
}

class HomePageDataState extends Equatable {
  const HomePageDataState(
      {this.status = HomepageStatus.initial, this.showDelete = false});
  final HomepageStatus status;
  final bool showDelete;

  HomePageDataState copyWith({required bool showDelete}) =>
      HomePageDataState(showDelete: showDelete);
  @override
  List<Object> get props => [showDelete];
}
