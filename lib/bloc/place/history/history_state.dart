import 'package:equatable/equatable.dart';
import 'package:limuny/model/PlaceHistoryModel.dart';

abstract class PlaceHistoryState extends Equatable {
  const PlaceHistoryState();
  @override
  List<Object> get props => [];
}

class PlaceHistoryInitial extends PlaceHistoryState {
  const PlaceHistoryInitial();
  @override
  List<Object> get props => [];
}

class PlaceHistoryLoading extends PlaceHistoryState {
  const PlaceHistoryLoading();
  @override
  List<Object> get props => [];
}

class PlaceHistoryFailure extends PlaceHistoryState {
  final String error;
  const PlaceHistoryFailure({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => 'LoginFailure { error: $error }';
}

class PlaceHistoryLoaded extends PlaceHistoryState {
  final List<Datum> history;
  const PlaceHistoryLoaded({required this.history});
  @override
  String toString() => 'HistoryLoaded { data: $history }';
  @override
  List<Object> get props => [history];
}
