import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:limuny/bloc/auth/auth.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:limuny/bloc/place/place_bloc.dart';
import 'package:limuny/bloc/place/place_event.dart';
import 'package:limuny/bloc/place/place_state.dart';
import 'package:limuny/bloc/user/user_bloc.dart';
import 'package:limuny/bloc/user/user_event.dart';
import 'package:limuny/bloc/user/user_state.dart';
import 'package:limuny/model/UserStatusModel.dart';
import 'package:limuny/styles/animation.dart';
import 'package:limuny/styles/theme.dart' as Style;
import 'package:limuny/ui/home/home_screen.dart';
import 'package:limuny/ui/place/checkin_scanner_screen.dart';
import 'package:limuny/ui/profile/profile_screen.dart';

class CheckInDetailScreen extends StatefulWidget {
  @override
  _chekInDetailScreen createState() => _chekInDetailScreen();
}

class _chekInDetailScreen extends State<CheckInDetailScreen> {
  final UserStatusBloc _userStatusBloc = UserStatusBloc();
  final PlaceBloc _placeBloc = PlaceBloc();

  @override
  void initState() {
    _userStatusBloc.add(GetUserStatus());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUserStatus(),
    );
  }

  Widget _buildUserStatus() {
    return Container(
      child: BlocProvider(
        create: (_) => _userStatusBloc,
        child: BlocListener<UserStatusBloc, UserStatusState>(
          listener: (context, state) {
            if (state is UserStatusFailure) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
          },
          child: BlocBuilder<UserStatusBloc, UserStatusState>(
            builder: (context, state) {
              if (state is UserStatusInitial) {
                return _buildLoading();
              } else if (state is UserStatusLoading) {
                return _buildLoading();
              } else if (state is UserStatusLoaded) {
                if (state.user.name == 'name') {
                  return _newCheckInLoaded(context, state.user);
                } else {
                  return _newCheckInLoaded(context, state.user);
                }
              } else if (state is UserStatusFailure) {
                return Container();
              } else if (state is UserCheckOutInitial) {
                return _buildLoading();
              } else if (state is UserCheckOutLoading) {
                return _buildLoading();
              } else if (state is UserCheckOutLoaded) {
                return MainScreen();
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget _newCheckInLoaded(BuildContext context, UserStatusModel place) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: mediaQuery.size.height / 3,
            child: FadeAnimation(
              1.2,
              Container(
                  padding: const EdgeInsets.all(30),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      colors: [
                        Style.Colors.facebookBlue,
                        Style.Colors.mainColor,
                      ],
                    ),
                  ),
                  child: Container()),
            ),
          ),
          Positioned(
            top: 50,
            left: 10,
            child: FadeAnimation(
              1.2,
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: mediaQuery.size.height / 1.4,
            child: FadeAnimation(
              1.2,
              Container(
                padding: const EdgeInsets.all(25),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeAnimation(
                        1.3,
                        Text(
                          place.activity_category,
                          style: GoogleFonts.poppins(
                            color: const Color.fromRGBO(97, 90, 90, .54),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(
                        1.3,
                        Text(
                          place.name,
                          style: GoogleFonts.poppins(
                            color: Style.Colors.mainColor,
                            fontSize: 23,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FadeAnimation(
                        1.4,
                        Text(
                          'Check-In pada ${place.checkin_date}',
                          style: GoogleFonts.poppins(
                            color: const Color.fromRGBO(51, 51, 51, .54),
                            fontSize: 16,
                            height: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FadeAnimation(
                          1.5,
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<UserStatusBloc>(context)
                                  .add(UserCheckOut());
                            },
                            child: Container(
                              height: 60,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                              ),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Style.Colors.facebookBlue,
                                    Style.Colors.mainColor,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    color: (Colors.grey[300]!),
                                    blurRadius: 10,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text(
                                        'Pengunjung ${place.quantity}/${place.capacity} ',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        'Orang',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Check-Out',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserStatusLoaded(
      BuildContext context, UserStatusModel user, bool isCheckin) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          isCheckin
              ? Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Color(0xFFF5F5F5),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1, -1),
                          child: Text(
                            'Silahkan Check-IN',
                          ),
                        ),
                        Align(
                            alignment: AlignmentDirectional(-1, 0),
                            child: RaisedButton(
                              child: Text('ChekIn'),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const CheckInScanner(),
                                ));
                              },
                            ))
                      ],
                    ),
                  ),
                )
              : Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Color(0xFFF5F5F5),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1, -1),
                          child: Text(
                            'Anda berada di ${user.name} pada ${user.checkin_date}',
                          ),
                        ),
                        Align(
                            alignment: AlignmentDirectional(-1, 0),
                            child: RaisedButton(
                              child: Text('Detail'),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CheckInDetailScreen()));
                              },
                            ))
                      ],
                    ),
                  ),
                )
        ],
      ),
    );
  }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Home"),
//         actions: [
//           IconButton(
//               icon: Icon(
//                 EvaIcons.logOutOutline,
//                 color: Style.Colors.colorWhite,
//               ),
//               onPressed: () {
//                 // BlocProvider.of<AuthenticationBloc>(context).add(
//                 //   LoggedOut(),
//                 // );
//               })
//         ],
//       ),
//       body: _buildUserStatus(),
//     );
//   }

//   Widget _buildUserStatus() {
//     return Container(
//       child: BlocProvider(
//         create: (_) => _userStatusBloc,
//         child: BlocListener<UserStatusBloc, UserStatusState>(
//           listener: (context, state) {
//             if (state is UserStatusFailure) {
//               Scaffold.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(state.error),
//                 ),
//               );
//             }
//           },
//           child: BlocBuilder<UserStatusBloc, UserStatusState>(
//             builder: (context, state) {
//               if (state is UserStatusInitial) {
//                 _buildLoading();
//               } else if (state is UserStatusLoading) {
//                 _buildLoading();
//               } else if (state is UserStatusLoaded) {
//                 state.user == null
//                     ? _buildLoading()
//                     : _buidlLoadedStatus(context, state.user);
//               } else if (state is UserStatusFailure) {
//                 return Container();
//               }
//               return Container();
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buidlLoadedStatus(BuildContext context, UserStatusModel user) {
//     return Container(
//       child: Text('${user.name}'),
//       //   child: Padding(
//       // padding: EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
//       // child: Column(children: [
//       //   SizedBox(
//       //     height: 48,
//       //   ),
//       //   Text(user.name),
//       //   SizedBox(
//       //     height: 48,
//       //   ),
//       //   Container(
//       //     width: MediaQuery.of(context).size.width,
//       //     height: 200,
//       //     decoration: BoxDecoration(
//       //       color: Style.Colors.colorWhite,
//       //     ),
//       //     child: Padding(
//       //       padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
//       //       child: Card(
//       //         clipBehavior: Clip.antiAliasWithSaveLayer,
//       //         color: Style.Colors.mainColor,
//       //         elevation: 1,
//       //         shape: RoundedRectangleBorder(
//       //           borderRadius: BorderRadius.circular(10),
//       //         ),
//       //         child: Stack(
//       //           children: [
//       //             Align(
//       //               alignment: AlignmentDirectional(0, -1),
//       //               child: Padding(
//       //                 padding: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 30),
//       //                 child: Text('Masuk ke Gedung atau Ruang Kelas ?',
//       //                     style: TextStyle(
//       //                         color: Style.Colors.colorWhite,
//       //                         fontSize: 21.0,
//       //                         fontWeight: FontWeight.bold)),
//       //               ),
//       //             ),
//       //             Align(
//       //               alignment: AlignmentDirectional(-0.8, 0.60),
//       //               child: RaisedButton(
//       //                 color: Style.Colors.orange, // background
//       //                 textColor: Colors.white, // foreground
//       //                 onPressed: () {
//       //                   Navigator.of(context).push(MaterialPageRoute(
//       //                     builder: (context) => const CheckInScanner(),
//       //                   ));
//       //                 },
//       //                 child: Text('Check-In'),
//       //               ),
//       //             ),
//       //           ],
//       //         ),
//       //       ),
//       //     ),
//     );
//   }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
