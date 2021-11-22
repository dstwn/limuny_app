import 'package:jiffy/jiffy.dart';
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
import 'package:limuny/styles/theme.dart' as Style;
import 'package:limuny/ui/history/history_screen.dart';
import 'package:limuny/ui/place/checkin_detail_screen.dart';
import 'package:limuny/ui/place/checkin_scanner_screen.dart';
import 'package:limuny/ui/profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final UserStatusBloc _userStatusBloc = UserStatusBloc();

  @override
  void initState() {
    _userStatusBloc.add(GetUserStatus());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              icon: Icon(
                EvaIcons.repeatOutline,
                color: Style.Colors.colorWhite,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PlaceHistoryScreen()));
              }),
          IconButton(
              icon: Icon(
                EvaIcons.personOutline,
                color: Style.Colors.colorWhite,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              }),
          IconButton(
              icon: Icon(
                EvaIcons.logOutOutline,
                color: Style.Colors.colorWhite,
              ),
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).add(
                  LoggedOut(),
                );
              })
        ],
      ),
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
                  return _buildUserStatusLoaded(context, state.user, true);
                } else {
                  return _buildUserStatusLoaded(context, state.user, false);
                }
              } else if (state is UserStatusFailure) {
                return Container();
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildUserStatusLoaded(
      BuildContext context, UserStatusModel user, bool isCheckin) {
    var date = null;

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
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
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
                            'Anda berada di ${user.name} pada ${new Jiffy(user.checkin_date).format("MMMM d yyyy, h:mm:ss a")}',
                          ),
                        ),
                        Align(
                            alignment: AlignmentDirectional(-1, 0),
                            child: RaisedButton(
                              child: Text('Detail'),
                              onPressed: () {
                                // Navigator.of(context).push(
                                //     MaterialPageRoute<PlaceBloc>(
                                //         builder: (_) => BlocProvider.value(
                                //             value: BlocProvider.of<PlaceBloc>(
                                //                     context)
                                //                 .add(CheckOut()))));
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
