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
import 'package:limuny/ui/shuttle/shuttle_screen.dart';

final List<String> imgList = [
  'https://ecs7.tokopedia.net/img/blog/promo/2020/06/Thumbnail3.jpg',
  'https://media.21cineplex.com/webcontent/gallery/pictures/157767538487410_925x527.jpg',
];

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Style.Colors.mainColor,
          title: Container(
            height: 50.0,
            decoration: BoxDecoration(
              color: Style.Colors.textWhiteGrey,
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Cari ...',
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ).copyWith(color: Style.Colors.textGrey),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                icon: Icon(
                  EvaIcons.clockOutline,
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
          ],
        ),
      ),
      body: _buildHomeMenus(),
    );
  }

  Widget _buildHomeMenus() {
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
                  return _buildUserStatus(context, state.user, true);
                } else {
                  return _buildUserStatus(context, state.user, false);
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

  Widget _buildUserStatus(
      BuildContext context, UserStatusModel user, bool isCheckin) {
    double widthSize = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Column(children: [
          Expanded(flex: 1, child: Container(color: Style.Colors.mainColor)),
          Expanded(flex: 10, child: Container(color: Colors.white))
        ]),
        Positioned(
          top: 0,
          left: 10,
          right: 10,
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    isCheckin
                        ? Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Style.Colors.colorWhite,
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  14, 14, 14, 14),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(-1, -1),
                                    child: Text(
                                      'Masuk ruang atau gedung ?',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Align(
                                      alignment: AlignmentDirectional(-1, 0),
                                      child: RaisedButton(
                                        child: Text('Chek-In'),
                                        onPressed: () {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                            builder: (context) =>
                                                const CheckInScanner(),
                                          ));
                                        },
                                      ))
                                ],
                              ),
                            ),
                          )
                        : Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Style.Colors.colorWhite,
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  14, 14, 14, 14),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(-1, -1),
                                    child: Text(
                                      'Anda berada di ${user.name} pada ${new Jiffy(user.checkin_date).format("MMMM d yyyy, h:mm:ss a")}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
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
                          ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlaceHistoryScreen()));
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.network(
                          'https://ik.imagekit.io/ewtwef9bw9x/barcode_8vxiQahO8.png?updatedAt=1637591625324',
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Riwayat\nCheck-In',
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShuttleScreen()));
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.network(
                          'https://ik.imagekit.io/ewtwef9bw9x/route_qdtFJZWKy.png?updatedAt=1637591625125',
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Suttle\nBus',
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.network(
                        'https://ik.imagekit.io/ewtwef9bw9x/vaccinated_JOQ5KjhWq.png?updatedAt=1637591625081',
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Hasil\nTes Covid',
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.network(
                        'https://ik.imagekit.io/ewtwef9bw9x/online-support_XZl_4jUWRH3.png?updatedAt=1637592153039',
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Crisis\nCenter',
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.network(
                        'https://ik.imagekit.io/ewtwef9bw9x/bell_1JDM-Zglf.png?updatedAt=1637592153207',
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Info\nPublik',
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildUserStatusLoaded(
      BuildContext context, UserStatusModel user, bool isCheckin) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 130 + MediaQuery.of(context).viewPadding.top,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF138880),
                        Color(0xFF1C9E82),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 100,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        )
      ],
    );
    return SafeArea(
        child: Column(
      children: [
        Container(
          child: Column(
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
                                      builder: (context) =>
                                          const CheckInScanner(),
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
                    ),
            ],
          ),
        ),
      ],
    ));
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
