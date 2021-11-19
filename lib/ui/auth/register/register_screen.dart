import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:limuny/bloc/auth/auth_bloc.dart';
import 'package:limuny/bloc/auth/auth.dart';
import 'package:limuny/bloc/register/register_bloc.dart';
import 'package:limuny/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:limuny/ui/auth/register/register_form.dart';

class RegisterScreen extends StatelessWidget {
  final UserRepository userRepository;
  RegisterScreen({Key? key, required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) {
          return RegisterBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
          );
        },
        child: RegisterForm(userRepository: userRepository),
      ),
    );
  }
}
