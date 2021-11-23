import 'package:equatable/equatable.dart';
import 'package:limuny/model/ShuttleHistoryModel.dart';

abstract class ShuttleHistoryState extends Equatable {
  const ShuttleHistoryState();
  @override
  List<Object> get props => [];
}

class ShuttleHistoryInitial extends ShuttleHistoryState {
  const ShuttleHistoryInitial();
  @override
  List<Object> get props => [];
}

class ShuttleHistoryLoading extends ShuttleHistoryState {
  const ShuttleHistoryLoading();
  @override
  List<Object> get props => [];
}

class ShuttleHistoryFailure extends ShuttleHistoryState {
  final String error;
  const ShuttleHistoryFailure({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => 'Load History ailure { error: $error }';
}

class ShuttleHistoryLoaded extends ShuttleHistoryState {
  final List<BusItem> history;
  const ShuttleHistoryLoaded({required this.history});
  @override
  String toString() => 'History Buses Loaded { data: $history }';
  @override
  List<Object> get props => [history];
}
