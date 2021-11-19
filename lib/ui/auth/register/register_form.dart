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
import 'package:limuny/ui/auth/login/login_screen.dart';
import 'package:limuny/widgets/custom_button.dart';
import 'package:limuny/widgets/custom_checkbox.dart';

class RegisterForm extends StatefulWidget {
  final UserRepository userRepository;
  RegisterForm({Key? key, required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState(userRepository);
}

class _RegisterFormState extends State<RegisterForm> {
  bool passwordVisible = false;
  bool cpasswordVisible = false;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
      cpasswordVisible = !cpasswordVisible;
    });
  }

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
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register new\nAccount',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ).copyWith(color: Style.Colors.secondBlack),
                        ),

                        // Image.asset(
                        //   'assets/images/accent.png',
                        //   width: 99,
                        //   height: 4,
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: 48,
                    ),
                    Form(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Style.Colors.textWhiteGrey,
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            child: TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                hintText: 'Name',
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ).copyWith(color: Style.Colors.textGrey),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Style.Colors.textWhiteGrey,
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ).copyWith(color: Style.Colors.textGrey),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Style.Colors.textWhiteGrey,
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            child: TextFormField(
                              obscureText: !passwordVisible,
                              controller: _passwordController,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ).copyWith(color: Style.Colors.textGrey),
                                suffixIcon: IconButton(
                                  color: Style.Colors.grey,
                                  splashRadius: 1,
                                  icon: Icon(passwordVisible
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined),
                                  onPressed: togglePassword,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Style.Colors.textWhiteGrey,
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            child: TextFormField(
                              obscureText: !cpasswordVisible,
                              controller: _passwordcController,
                              decoration: InputDecoration(
                                hintText: 'Password Confirmation',
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ).copyWith(color: Style.Colors.textGrey),
                                suffixIcon: IconButton(
                                  color: Style.Colors.grey,
                                  splashRadius: 1,
                                  icon: Icon(cpasswordVisible
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined),
                                  onPressed: togglePassword,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Style.Colors.textWhiteGrey,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: TextFormField(
                        controller: _nikController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Citizen ID',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ).copyWith(color: Style.Colors.textGrey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Style.Colors.textWhiteGrey,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: TextFormField(
                        controller: _nimController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Student ID',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ).copyWith(color: Style.Colors.textGrey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Style.Colors.textWhiteGrey,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Phone Number',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ).copyWith(color: Style.Colors.textGrey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Style.Colors.textWhiteGrey,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: TextFormField(
                        controller: _majorController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Major',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ).copyWith(color: Style.Colors.textGrey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomCheckbox(),
                        SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'By creating an account, you agree to our',
                              style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w400)
                                  .copyWith(color: Style.Colors.textGrey),
                            ),
                            Text(
                              'Terms & Conditions',
                              style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w400)
                                  .copyWith(color: Style.Colors.mainColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                        child: state is RegisterLoading
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                            : Material(
                                borderRadius: BorderRadius.circular(14.0),
                                elevation: 0,
                                child: Container(
                                  height: 56,
                                  decoration: BoxDecoration(
                                    color: Style.Colors.mainColor,
                                    borderRadius: BorderRadius.circular(14.0),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: RaisedButton(
                                      color: Style.Colors.mainColor,
                                      disabledColor: Style.Colors.textWhiteGrey,
                                      disabledTextColor: Style.Colors.textGrey,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14.0)),
                                      onPressed: _onRegisterButtonPressed,
                                      child: Center(
                                        child: Text(
                                          "Register",
                                          style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600)
                                              .copyWith(
                                                  color:
                                                      Style.Colors.colorWhite),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                    SizedBox(
                      height: 24,
                    ),
                    Center(
                      child: Text(
                        'OR',
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w600)
                                .copyWith(color: Style.Colors.grey),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    CustomPrimaryButton(
                      buttonColor: Style.Colors.titleColor,
                      textValue: 'Register with SSO',
                      textColor: Style.Colors.greyBack,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400)
                              .copyWith(color: Style.Colors.grey),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen(
                                          userRepository: userRepository,
                                        )));
                          },
                          child: Text(
                            'Login Now',
                            style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400)
                                .copyWith(color: Style.Colors.mainColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        // builder: (context, state) {
        //   return Padding(
        //     padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 80.0),
        //     child: Form(
        //       child: Column(children: [
        //         Container(
        //             height: 100.0,
        //             padding: EdgeInsets.only(bottom: 0.0, top: 40.0),
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Text(
        //                   "LIMUNY",
        //                   style: TextStyle(
        //                       color: Style.Colors.mainColor,
        //                       fontWeight: FontWeight.bold,
        //                       fontSize: 24.0),
        //                 ),
        //                 SizedBox(
        //                   height: 5.0,
        //                 ),
        //                 Text(
        //                   "Lindungi Mahasiswa UNY",
        //                   style:
        //                       TextStyle(fontSize: 10.0, color: Colors.black38),
        //                 )
        //               ],
        //             )),
        //         SizedBox(
        //           height: 20.0,
        //         ),
        //         TextFormField(
        //           style: TextStyle(
        //               fontSize: 14.0,
        //               color: Style.Colors.titleColor,
        //               fontWeight: FontWeight.bold),
        //           controller: _nameController,
        //           keyboardType: TextInputType.text,
        //           decoration: InputDecoration(
        //             prefixIcon:
        //                 Icon(EvaIcons.emailOutline, color: Colors.black26),
        //             enabledBorder: OutlineInputBorder(
        //                 borderSide: new BorderSide(color: Colors.black12),
        //                 borderRadius: BorderRadius.circular(30.0)),
        //             focusedBorder: OutlineInputBorder(
        //                 borderSide:
        //                     new BorderSide(color: Style.Colors.mainColor),
        //                 borderRadius: BorderRadius.circular(30.0)),
        //             contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
        //             labelText: "Name",
        //             hintStyle: TextStyle(
        //                 fontSize: 12.0,
        //                 color: Style.Colors.grey,
        //                 fontWeight: FontWeight.w500),
        //             labelStyle: TextStyle(
        //                 fontSize: 12.0,
        //                 color: Colors.grey,
        //                 fontWeight: FontWeight.w500),
        //           ),
        //           autocorrect: false,
        //         ),
        //         SizedBox(
        //           height: 20.0,
        //         ),
        //         TextFormField(
        //           style: TextStyle(
        //               fontSize: 14.0,
        //               color: Style.Colors.titleColor,
        //               fontWeight: FontWeight.bold),
        //           controller: _emailController,
        //           keyboardType: TextInputType.emailAddress,
        //           decoration: InputDecoration(
        //             prefixIcon:
        //                 Icon(EvaIcons.emailOutline, color: Colors.black26),
        //             enabledBorder: OutlineInputBorder(
        //                 borderSide: new BorderSide(color: Colors.black12),
        //                 borderRadius: BorderRadius.circular(30.0)),
        //             focusedBorder: OutlineInputBorder(
        //                 borderSide:
        //                     new BorderSide(color: Style.Colors.mainColor),
        //                 borderRadius: BorderRadius.circular(30.0)),
        //             contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
        //             labelText: "E-Mail",
        //             hintStyle: TextStyle(
        //                 fontSize: 12.0,
        //                 color: Style.Colors.grey,
        //                 fontWeight: FontWeight.w500),
        //             labelStyle: TextStyle(
        //                 fontSize: 12.0,
        //                 color: Colors.grey,
        //                 fontWeight: FontWeight.w500),
        //           ),
        //           autocorrect: false,
        //         ),
        //         SizedBox(
        //           height: 20.0,
        //         ),
        //         TextFormField(
        //           style: TextStyle(
        //               fontSize: 14.0,
        //               color: Style.Colors.titleColor,
        //               fontWeight: FontWeight.bold),
        //           controller: _passwordController,
        //           decoration: InputDecoration(
        //             fillColor: Colors.white,
        //             prefixIcon: Icon(
        //               EvaIcons.lockOutline,
        //               color: Colors.black26,
        //             ),
        //             enabledBorder: OutlineInputBorder(
        //                 borderSide: new BorderSide(color: Colors.black12),
        //                 borderRadius: BorderRadius.circular(30.0)),
        //             focusedBorder: OutlineInputBorder(
        //                 borderSide:
        //                     new BorderSide(color: Style.Colors.mainColor),
        //                 borderRadius: BorderRadius.circular(30.0)),
        //             contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
        //             labelText: "Password",
        //             hintStyle: TextStyle(
        //                 fontSize: 12.0,
        //                 color: Style.Colors.grey,
        //                 fontWeight: FontWeight.w500),
        //             labelStyle: TextStyle(
        //                 fontSize: 12.0,
        //                 color: Colors.grey,
        //                 fontWeight: FontWeight.w500),
        //           ),
        //           autocorrect: false,
        //           obscureText: true,
        //         ),
        //         SizedBox(
        //           height: 20.0,
        //         ),
        //         TextFormField(
        //           style: TextStyle(
        //               fontSize: 14.0,
        //               color: Style.Colors.titleColor,
        //               fontWeight: FontWeight.bold),
        //           controller: _passwordcController,
        //           decoration: InputDecoration(
        //             fillColor: Colors.white,
        //             prefixIcon: Icon(
        //               EvaIcons.lockOutline,
        //               color: Colors.black26,
        //             ),
        //             enabledBorder: OutlineInputBorder(
        //                 borderSide: new BorderSide(color: Colors.black12),
        //                 borderRadius: BorderRadius.circular(30.0)),
        //             focusedBorder: OutlineInputBorder(
        //                 borderSide:
        //                     new BorderSide(color: Style.Colors.mainColor),
        //                 borderRadius: BorderRadius.circular(30.0)),
        //             contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
        //             labelText: "Password Confirmation",
        //             hintStyle: TextStyle(
        //                 fontSize: 12.0,
        //                 color: Style.Colors.grey,
        //                 fontWeight: FontWeight.w500),
        //             labelStyle: TextStyle(
        //                 fontSize: 12.0,
        //                 color: Colors.grey,
        //                 fontWeight: FontWeight.w500),
        //           ),
        //           autocorrect: false,
        //           obscureText: true,
        //         ),
        //         SizedBox(
        //           height: 20.0,
        //         ),
        //         TextFormField(
        //           style: TextStyle(
        //               fontSize: 14.0,
        //               color: Style.Colors.titleColor,
        //               fontWeight: FontWeight.bold),
        //           controller: _nimController,
        //           keyboardType: TextInputType.number,
        //           decoration: InputDecoration(
        //             prefixIcon:
        //                 Icon(EvaIcons.hashOutline, color: Colors.black26),
        //             enabledBorder: OutlineInputBorder(
        //                 borderSide: new BorderSide(color: Colors.black12),
        //                 borderRadius: BorderRadius.circular(30.0)),
        //             focusedBorder: OutlineInputBorder(
        //                 borderSide:
        //                     new BorderSide(color: Style.Colors.mainColor),
        //                 borderRadius: BorderRadius.circular(30.0)),
        //             contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
        //             labelText: "NIM",
        //             hintStyle: TextStyle(
        //                 fontSize: 12.0,
        //                 color: Style.Colors.grey,
        //                 fontWeight: FontWeight.w500),
        //             labelStyle: TextStyle(
        //                 fontSize: 12.0,
        //                 color: Colors.grey,
        //                 fontWeight: FontWeight.w500),
        //           ),
        //           autocorrect: false,
        //         ),
        //         SizedBox(
        //           height: 20.0,
        //         ),
        //         TextFormField(
        //           style: TextStyle(
        //               fontSize: 14.0,
        //               color: Style.Colors.titleColor,
        //               fontWeight: FontWeight.bold),
        //           controller: _nikController,
        //           keyboardType: TextInputType.number,
        //           decoration: InputDecoration(
        //             prefixIcon:
        //                 Icon(EvaIcons.personDoneOutline, color: Colors.black26),
        //             enabledBorder: OutlineInputBorder(
        //                 borderSide: new BorderSide(color: Colors.black12),
        //                 borderRadius: BorderRadius.circular(30.0)),
        //             focusedBorder: OutlineInputBorder(
        //                 borderSide:
        //                     new BorderSide(color: Style.Colors.mainColor),
        //                 borderRadius: BorderRadius.circular(30.0)),
        //             contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
        //             labelText: "NIK",
        //             hintStyle: TextStyle(
        //                 fontSize: 12.0,
        //                 color: Style.Colors.grey,
        //                 fontWeight: FontWeight.w500),
        //             labelStyle: TextStyle(
        //                 fontSize: 12.0,
        //                 color: Colors.grey,
        //                 fontWeight: FontWeight.w500),
        //           ),
        //           autocorrect: false,
        //         ),
        //         SizedBox(
        //           height: 20.0,
        //         ),
        //         TextFormField(
        //           style: TextStyle(
        //               fontSize: 14.0,
        //               color: Style.Colors.titleColor,
        //               fontWeight: FontWeight.bold),
        //           controller: _phoneController,
        //           keyboardType: TextInputType.number,
        //           decoration: InputDecoration(
        //             prefixIcon:
        //                 Icon(EvaIcons.phoneOutline, color: Colors.black26),
        //             enabledBorder: OutlineInputBorder(
        //                 borderSide: new BorderSide(color: Colors.black12),
        //                 borderRadius: BorderRadius.circular(30.0)),
        //             focusedBorder: OutlineInputBorder(
        //                 borderSide:
        //                     new BorderSide(color: Style.Colors.mainColor),
        //                 borderRadius: BorderRadius.circular(30.0)),
        //             contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
        //             labelText: "Phone",
        //             hintStyle: TextStyle(
        //                 fontSize: 12.0,
        //                 color: Style.Colors.grey,
        //                 fontWeight: FontWeight.w500),
        //             labelStyle: TextStyle(
        //                 fontSize: 12.0,
        //                 color: Colors.grey,
        //                 fontWeight: FontWeight.w500),
        //           ),
        //           autocorrect: false,
        //         ),
        //         SizedBox(
        //           height: 20.0,
        //         ),
        //         TextFormField(
        //           style: TextStyle(
        //               fontSize: 14.0,
        //               color: Style.Colors.titleColor,
        //               fontWeight: FontWeight.bold),
        //           controller: _majorController,
        //           keyboardType: TextInputType.text,
        //           decoration: InputDecoration(
        //             prefixIcon:
        //                 Icon(EvaIcons.npmOutline, color: Colors.black26),
        //             enabledBorder: OutlineInputBorder(
        //                 borderSide: new BorderSide(color: Colors.black12),
        //                 borderRadius: BorderRadius.circular(30.0)),
        //             focusedBorder: OutlineInputBorder(
        //                 borderSide:
        //                     new BorderSide(color: Style.Colors.mainColor),
        //                 borderRadius: BorderRadius.circular(30.0)),
        //             contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
        //             labelText: "Major",
        //             hintStyle: TextStyle(
        //                 fontSize: 12.0,
        //                 color: Style.Colors.grey,
        //                 fontWeight: FontWeight.w500),
        //             labelStyle: TextStyle(
        //                 fontSize: 12.0,
        //                 color: Colors.grey,
        //                 fontWeight: FontWeight.w500),
        //           ),
        //           autocorrect: false,
        //         ),
        //         SizedBox(
        //           height: 20.0,
        //         ),
        //         Padding(
        //           padding: EdgeInsets.only(top: 30.0, bottom: 20.0),
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.stretch,
        //             children: <Widget>[
        //               SizedBox(
        //                   height: 45,
        //                   child: state is RegisterLoading
        //                       ? Column(
        //                           crossAxisAlignment: CrossAxisAlignment.center,
        //                           mainAxisAlignment: MainAxisAlignment.center,
        //                           children: <Widget>[
        //                             Center(
        //                                 child: Column(
        //                               mainAxisAlignment:
        //                                   MainAxisAlignment.center,
        //                               children: [
        //                                 SizedBox(
        //                                   height: 25.0,
        //                                   width: 25.0,
        //                                   child: CupertinoActivityIndicator(),
        //                                 )
        //                               ],
        //                             ))
        //                           ],
        //                         )
        //                       : RaisedButton(
        //                           color: Style.Colors.mainColor,
        //                           disabledColor: Style.Colors.mainColor,
        //                           disabledTextColor: Colors.white,
        //                           shape: RoundedRectangleBorder(
        //                             borderRadius: BorderRadius.circular(30.0),
        //                           ),
        //                           onPressed: _onRegisterButtonPressed,
        //                           child: Text("REGISTER",
        //                               style: new TextStyle(
        //                                   fontSize: 12.0,
        //                                   fontWeight: FontWeight.bold,
        //                                   color: Colors.white)))),
        //             ],
        //           ),
        //         ),
        //       ]),
        //     ),
        //   );
        //},
      ),
    );
  }
}
