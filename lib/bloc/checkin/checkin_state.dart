import 'package:equatable/equatable.dart';
import 'package:limuny/model/UserStatusModel.dart';

abstract class CheckInState extends Equatable {
  const CheckInState();
  @override
  List<Object> get props => [];
}

class CheckInStateInitial extends CheckInState {
  const CheckInStateInitial();
  @override
  List<Object> get props => [];
}

class CheckInStateLoading extends CheckInState {
  const CheckInStateLoading();
  @override
  List<Object> get props => [];
}

class CheckInStateFailure extends CheckInState {
  final String error;
  const CheckInStateFailure({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => 'LoginFailure { error: $error }';
}

class CheckInStateLoaded extends CheckInState {
  final UserStatusModel user;
  const CheckInStateLoaded(this.user);
  @override
  String toString() => 'ProfileLoaded { data: $user }';
  @override
  List<Object> get props => [user];
}
