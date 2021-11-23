import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:limuny/bloc/shuttle/shuttle_bloc.dart';
import 'package:limuny/bloc/shuttle/shuttle_event.dart';
import 'package:limuny/bloc/shuttle/shuttle_state.dart';
import 'package:limuny/model/ShuttleDetailModel.dart';
import 'package:limuny/styles/theme.dart' as Style;
import 'package:limuny/ui/shuttle/shuttle_screen.dart';

class ConfirmationShuttle extends StatefulWidget {
  final String? uuid;
  const ConfirmationShuttle({Key? key, required this.uuid}) : super(key: key);

  @override
  _ConfirmationShuttleState createState() => _ConfirmationShuttleState();
}

class _ConfirmationShuttleState extends State<ConfirmationShuttle> {
  final ShuttleBloc _shuttleBloc = ShuttleBloc();

  @override
  void initState() {
    _shuttleBloc.add(GetDetailShuttle(uuid: widget.uuid.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildConfirmation(),
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
  Widget _buildConfirmation() {
    return Container(
        child: BlocProvider(
            create: (_) => _shuttleBloc,
            child: BlocListener<ShuttleBloc, ShuttleState>(
              listener: (context, state) {
                if (state is ShuttleFailure) {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
              child: BlocBuilder<ShuttleBloc, ShuttleState>(
                builder: (context, state) {
                  if (state is ShuttleDetailInitial) {
                    return _buildLoading();
                  } else if (state is ShuttleDetailLoading) {
                    return _buildLoading();
                  } else if (state is ShuttleDetailLoaded) {
                    return _buildShuttleDetailLoaded(
                        context, state.shuttleDetailModel);
                  } else if (state is ShuttleDetailFailure) {
                    return Container();
                  }
                  return Container();
                },
              ),
            )));
  }

  Widget _buildShuttleDetailLoaded(
      BuildContext context, ShuttleDetailModel shuttleDetailModel) {
    return Scaffold(
      backgroundColor: Style.Colors.colorWhite,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: Style.Colors.titleColor,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: IconButton(
                        // borderColor: Colors.transparent,
                        // borderRadius: 30,
                        // buttonSize: 46,
                        icon: Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () async {
                          Navigator.pushReplacement(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new ShuttleScreen()),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Style.Colors.mainColor,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(70),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 30),
                    child: Icon(
                      Icons.check_outlined,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                child: Text(
                  shuttleDetailModel.code,
                  style: TextStyle(
                    fontFamily: 'Lexend Deca',
                    color: Style.Colors.mainColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24, 8, 24, 0),
                child: Chip(
                  labelPadding: EdgeInsets.all(2.0),
                  label: Text(
                    "Departure ${shuttleDetailModel.departureTime}",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Style.Colors.orange,
                  elevation: 0.0,
                  shadowColor: Colors.grey[60],
                  padding: EdgeInsets.all(10.0),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24, 8, 24, 0),
                child: Text(
                  '${shuttleDetailModel.quantity} dari ${shuttleDetailModel.capacity}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Lexend Deca',
                    color: Style.Colors.titleColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24, 8, 24, 0),
                child: Text(
                  'to check-in Location, don\'t forget to Wear a Mask, keep social distancing',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Lexend Deca',
                    color: Color(0xFF8B97A2),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // ElevatedButton(
                      //     onPressed: () => {
                      //           BlocProvider.of<PlaceBloc>(context)
                      //               .add((CheckOut()))
                      //         },
                      //     child: Text("CHECK-OUT"),
                      //     style: ElevatedButton.styleFrom(
                      //       elevation: 0,
                      //       primary: Style.Colors.successGreen,
                      //       shape: StadiumBorder(),
                      //     ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
