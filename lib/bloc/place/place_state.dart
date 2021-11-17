import 'package:equatable/equatable.dart';
import 'package:limuny/bloc/place/place_event.dart';
import 'package:limuny/bloc/profile/profile_state.dart';
import 'package:limuny/model/CheckInModel.dart';
import 'package:limuny/model/PlaceModel.dart';

abstract class PlaceState extends Equatable {
  const PlaceState();
  @override
  List<Object> get props => [];
}

class PlaceInitial extends PlaceState {
  const PlaceInitial();
  @override
  List<Object> get props => [];
}

class CheckInInitial extends PlaceState {
  const CheckInInitial();
  @override
  List<Object> get props => [];
}

class PlaceLoading extends PlaceState {
  const PlaceLoading();
  @override
  List<Object> get props => [];
}

class CheckInLoading extends PlaceState {}

class PlaceFailure extends PlaceState {
  final String error;
  const PlaceFailure({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => 'LoginFailure { error: $error }';
}

class CheckInFailure extends PlaceState {
  final String error;
  const CheckInFailure({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => 'CheckInFailure { error: $error }';
}

class CheckInLoaded extends PlaceState {
  final CheckInModel checkin;
  const CheckInLoaded(this.checkin);
  @override
  String toString() => 'PlaceLoaded { data: $checkin }';
  @override
  List<Object> get props => [checkin];
}

class PlaceLoaded extends PlaceState {
  final Place place;
  const PlaceLoaded(this.place);
  @override
  String toString() => 'PlaceLoaded { data: $place }';
  @override
  List<Object> get props => [place];
}
