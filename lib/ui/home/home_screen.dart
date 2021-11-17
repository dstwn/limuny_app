import 'package:limuny/bloc/auth/auth.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:limuny/bloc/place/place_bloc.dart';
import 'package:limuny/bloc/place/place_state.dart';
import 'package:limuny/styles/theme.dart' as Style;
import 'package:limuny/ui/place/checkin_scanner_screen.dart';
import 'package:limuny/ui/profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PlaceBloc placeBloc = PlaceBloc();

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child: BlocProvider(
    //     create: (_) => placeBloc,
    //     child: BlocListener<PlaceBloc, PlaceState>(
    //       listener: (context, state) {
    //         if (state is CheckInLoaded) {
    //           // ignore: void_checks
    //           _buildLoading();
    //         }
    //       },
    //     ),
    //   ),
    // );
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Style.Colors.colorWhite,
          title: const Text(
            "LIMUNY APPS",
            style: TextStyle(
                color: Style.Colors.mainColor,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  EvaIcons.personOutline,
                  color: Style.Colors.mainColor,
                ),
                onPressed: () {
                  // BlocProvider.of<AuthenticationBloc>(context).add(
                  //   LoggedOut(),
                  // );
                  //to profile
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ProfileScreen();
                  }));
                })
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          decoration: BoxDecoration(
            color: Style.Colors.colorWhite,
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Style.Colors.mainColor,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, -1),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 30),
                      child: Text('Masuk ke Gedung atau Ruang Kelas ?',
                          style: TextStyle(
                              color: Style.Colors.colorWhite,
                              fontSize: 21.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-0.8, 0.60),
                    child: RaisedButton(
                      color: Style.Colors.orange, // background
                      textColor: Colors.white, // foreground
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CheckInScanner(),
                        ));
                      },
                      child: Text('Check-In'),
                    ),
                    // child: FFButtonWidget(
                    //   onPressed: () {
                    //     print('Button pressed ...');
                    //   },
                    //   text: 'Check-In',
                    //   icon: Icon(
                    //     Icons.qr_code_rounded,
                    //     size: 15,
                    //   ),
                    //   options: FFButtonOptions(
                    //     width: 130,
                    //     height: 40,
                    //     color: FlutterFlowTheme.tertiaryColor,
                    //     textStyle: FlutterFlowTheme.bodyText2.override(
                    //       fontFamily: 'Open Sans',
                    //     ),
                    //     borderSide: BorderSide(
                    //       color: Colors.transparent,
                    //       width: 1,
                    //     ),
                    //     borderRadius: 100,
                    //   ),
                    //   loading: _loadingButton,
                    // ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
