import 'package:equatable/equatable.dart';
import 'package:limuny/model/CheckOutModel.dart';
import 'package:limuny/model/UserStatusModel.dart';

abstract class UserStatusState extends Equatable {
  const UserStatusState();
  @override
  List<Object> get props => [];
}

class UserStatusInitial extends UserStatusState {
  const UserStatusInitial();
  @override
  List<Object> get props => [];
}

class UserStatusLoading extends UserStatusState {
  const UserStatusLoading();
  @override
  List<Object> get props => [];
}

class UserStatusFailure extends UserStatusState {
  final String error;
  const UserStatusFailure({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => 'LoginFailure { error: $error }';
}

class UserStatusLoaded extends UserStatusState {
  final UserStatusModel user;
  const UserStatusLoaded(this.user);
  @override
  String toString() => 'StatusUserLoaded { data: $user }';
  @override
  List<Object> get props => [user];
}

class UserCheckOutInitial extends UserStatusState {
  const UserCheckOutInitial();
  @override
  List<Object> get props => [];
}

class UserCheckOutLoaded extends UserStatusState {
  final CheckOutModel checkOutModel;
  const UserCheckOutLoaded(this.checkOutModel);
  @override
  List<Object> get props => [checkOutModel];
}

class UserCheckOutFailure extends UserStatusState {
  final String error;
  const UserCheckOutFailure({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => 'CheckOutFailure { error: $error }';
}

class UserCheckOutLoading extends UserStatusState {}
