import 'package:limuny/bloc/login/login_bloc.dart';
import 'package:limuny/bloc/register/register_bloc.dart';
import 'package:limuny/bloc/register/register_event.dart';
import 'package:limuny/bloc/register/register_state.dart';
import 'package:limuny/repositories/user_repository.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:limuny/styles/theme.dart' as Style;

class RegisterForm extends StatefulWidget {
  final UserRepository userRepository;
  RegisterForm({Key? key, required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState(userRepository);
}

class _RegisterFormState extends State<RegisterForm> {
  final UserRepository userRepository;
  _RegisterFormState(this.userRepository);
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordcController = TextEditingController();
  final _nimController = TextEditingController();
  final _nikController = TextEditingController();
  final _majorController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _onRegisterButtonPressed() {
      BlocProvider.of<RegisterBloc>(context).add(RegisterButtonPressed(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          password_c: _passwordcController.text,
          nim: _nimController.text,
          nik: _nikController.text,
          major: _majorController.text,
          phone: _phoneController.text));
    }

    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Register failed."),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 80.0),
            child: Form(
              child: Column(children: [
                Container(
                    height: 100.0,
                    padding: EdgeInsets.only(bottom: 0.0, top: 40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "LIMUNY",
                          style: TextStyle(
                              color: Style.Colors.mainColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "Lindungi Mahasiswa UNY",
                          style:
                              TextStyle(fontSize: 10.0, color: Colors.black38),
                        )
                      ],
                    )),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Style.Colors.titleColor,
                      fontWeight: FontWeight.bold),
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon:
                        Icon(EvaIcons.emailOutline, color: Colors.black26),
                    enabledBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(30.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Style.Colors.mainColor),
                        borderRadius: BorderRadius.circular(30.0)),
                    contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
                    labelText: "Name",
                    hintStyle: TextStyle(
                        fontSize: 12.0,
                        color: Style.Colors.grey,
                        fontWeight: FontWeight.w500),
                    labelStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  autocorrect: false,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Style.Colors.titleColor,
                      fontWeight: FontWeight.bold),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon:
                        Icon(EvaIcons.emailOutline, color: Colors.black26),
                    enabledBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(30.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Style.Colors.mainColor),
                        borderRadius: BorderRadius.circular(30.0)),
                    contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
                    labelText: "E-Mail",
                    hintStyle: TextStyle(
                        fontSize: 12.0,
                        color: Style.Colors.grey,
                        fontWeight: FontWeight.w500),
                    labelStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  autocorrect: false,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Style.Colors.titleColor,
                      fontWeight: FontWeight.bold),
                  controller: _passwordController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      EvaIcons.lockOutline,
                      color: Colors.black26,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(30.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Style.Colors.mainColor),
                        borderRadius: BorderRadius.circular(30.0)),
                    contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
                    labelText: "Password",
                    hintStyle: TextStyle(
                        fontSize: 12.0,
                        color: Style.Colors.grey,
                        fontWeight: FontWeight.w500),
                    labelStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  autocorrect: false,
                  obscureText: true,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Style.Colors.titleColor,
                      fontWeight: FontWeight.bold),
                  controller: _passwordcController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      EvaIcons.lockOutline,
                      color: Colors.black26,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(30.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Style.Colors.mainColor),
                        borderRadius: BorderRadius.circular(30.0)),
                    contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
                    labelText: "Password Confirmation",
                    hintStyle: TextStyle(
                        fontSize: 12.0,
                        color: Style.Colors.grey,
                        fontWeight: FontWeight.w500),
                    labelStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  autocorrect: false,
                  obscureText: true,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Style.Colors.titleColor,
                      fontWeight: FontWeight.bold),
                  controller: _nimController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon:
                        Icon(EvaIcons.hashOutline, color: Colors.black26),
                    enabledBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(30.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Style.Colors.mainColor),
                        borderRadius: BorderRadius.circular(30.0)),
                    contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
                    labelText: "NIM",
                    hintStyle: TextStyle(
                        fontSize: 12.0,
                        color: Style.Colors.grey,
                        fontWeight: FontWeight.w500),
                    labelStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  autocorrect: false,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Style.Colors.titleColor,
                      fontWeight: FontWeight.bold),
                  controller: _nikController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon:
                        Icon(EvaIcons.personDoneOutline, color: Colors.black26),
                    enabledBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(30.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Style.Colors.mainColor),
                        borderRadius: BorderRadius.circular(30.0)),
                    contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
                    labelText: "NIK",
                    hintStyle: TextStyle(
                        fontSize: 12.0,
                        color: Style.Colors.grey,
                        fontWeight: FontWeight.w500),
                    labelStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  autocorrect: false,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Style.Colors.titleColor,
                      fontWeight: FontWeight.bold),
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon:
                        Icon(EvaIcons.phoneOutline, color: Colors.black26),
                    enabledBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(30.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Style.Colors.mainColor),
                        borderRadius: BorderRadius.circular(30.0)),
                    contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
                    labelText: "Phone",
                    hintStyle: TextStyle(
                        fontSize: 12.0,
                        color: Style.Colors.grey,
                        fontWeight: FontWeight.w500),
                    labelStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  autocorrect: false,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Style.Colors.titleColor,
                      fontWeight: FontWeight.bold),
                  controller: _majorController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon:
                        Icon(EvaIcons.npmOutline, color: Colors.black26),
                    enabledBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(30.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Style.Colors.mainColor),
                        borderRadius: BorderRadius.circular(30.0)),
                    contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
                    labelText: "Major",
                    hintStyle: TextStyle(
                        fontSize: 12.0,
                        color: Style.Colors.grey,
                        fontWeight: FontWeight.w500),
                    labelStyle: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  autocorrect: false,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30.0, bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                          height: 45,
                          child: state is RegisterLoading
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 25.0,
                                          width: 25.0,
                                          child: CupertinoActivityIndicator(),
                                        )
                                      ],
                                    ))
                                  ],
                                )
                              : RaisedButton(
                                  color: Style.Colors.mainColor,
                                  disabledColor: Style.Colors.mainColor,
                                  disabledTextColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  onPressed: _onRegisterButtonPressed,
                                  child: Text("REGISTER",
                                      style: new TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)))),
                    ],
                  ),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
