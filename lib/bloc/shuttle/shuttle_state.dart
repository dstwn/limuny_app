import 'package:equatable/equatable.dart';
import 'package:limuny/model/ShuttleDetailModel.dart';
import 'package:limuny/model/ShuttleModel.dart';

abstract class ShuttleState extends Equatable {
  const ShuttleState();
  @override
  List<Object> get props => [];
}

class ShuttleInital extends ShuttleState {
  const ShuttleInital();
  @override
  List<Object> get props => [];
}

class ShuttleLoading extends ShuttleState {
  const ShuttleLoading();
  @override
  List<Object> get props => [];
}

class ShuttleFailure extends ShuttleState {
  final String error;
  const ShuttleFailure({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => 'ShuttleLoadFailure { error: $error }';
}

class ShuttleLoaded extends ShuttleState {
  List<Bus> shuttle;
  ShuttleLoaded({required this.shuttle});
  @override
  String toString() => 'HistoryLoaded { data: $shuttle }';
  @override
  List<Object> get props => [shuttle];
}

class ShuttleDetailInitial extends ShuttleState {
  const ShuttleDetailInitial();
  @override
  List<Object> get props => [];
}

class ShuttleDetailLoading extends ShuttleState {
  const ShuttleDetailLoading();
  @override
  List<Object> get props => [];
}

class ShuttleDetailFailure extends ShuttleState {
  final String error;
  const ShuttleDetailFailure({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => 'Loaded Shuttle Failure { error: $error }';
}

class ShuttleDetailLoaded extends ShuttleState {
  final ShuttleDetailModel shuttleDetailModel;
  const ShuttleDetailLoaded({required this.shuttleDetailModel});
  @override
  List<Object> get props => [shuttleDetailModel];
}
