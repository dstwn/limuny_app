import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AuthenticaionEvent extends Equatable {
  const AuthenticaionEvent();
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticaionEvent {}

class LoggedIn extends AuthenticaionEvent {
  final token;
  const LoggedIn({required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'LoggedIn { token: $token }';
}

class Registered extends AuthenticaionEvent {
  final token;
  const Registered({required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'Registered { token: $token }';
}

class LoggedOut extends AuthenticaionEvent {}
