import 'package:equatable/equatable.dart';
import 'package:limuny/model/UserModel.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
  @override
  List<Object> get props => [];
}

class ProfileFailure extends ProfileState {
  final String error;
  const ProfileFailure({required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => 'LoginFailure { error: $error }';
}

class ProfileLoaded extends ProfileState {
  final User user;
  const ProfileLoaded(this.user);
  @override
  String toString() => 'ProfileLoaded { data: $user }';
  @override
  List<Object> get props => [user];
}
