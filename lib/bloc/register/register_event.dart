import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterButtonPressed extends RegisterEvent {
  final String name;
  final String email;
  final String password;
  final String password_c;
  final String nim;
  final String nik;
  final String major;
  final String phone;
  const RegisterButtonPressed(
      {required this.name,
      required this.email,
      required this.password,
      required this.password_c,
      required this.nim,
      required this.nik,
      required this.major,
      required this.phone});

  @override
  List<Object> get props =>
      [name, email, password, password_c, nim, nik, major, phone];
  @override
  String toString() =>
      'RegisterButtonPressed { name: $name, email: $email, password: $password, password_c : $password_c, nim : $nim,nik : $nik, major : $major, phone : $phone }';
}
