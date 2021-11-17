import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:limuny/bloc/place/place_bloc.dart';
import 'package:limuny/bloc/place/place_event.dart';
import 'package:limuny/bloc/place/place_state.dart';
import 'package:limuny/model/PlaceModel.dart';
import 'package:qr_code_scanner/src/types/barcode.dart';
import 'package:limuny/styles/theme.dart' as Style;

class ConfirmationPlaceScreen extends StatefulWidget {
  final String? uuid;
  const ConfirmationPlaceScreen({Key? key, required this.uuid})
      : super(key: key);

  @override
  _ConfirmationPlaceScreenState createState() =>
      _ConfirmationPlaceScreenState();
}

class _ConfirmationPlaceScreenState extends State<ConfirmationPlaceScreen> {
  final PlaceBloc placeBloc = PlaceBloc();

  @override
  void initState() {
    placeBloc.add(GetPlace(uuid: widget.uuid.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildConfirmation(),
    );
  }

  Widget _buildConfirmation() {
    return Container(
      child: BlocProvider(
        create: (_) => placeBloc,
        child: BlocListener<PlaceBloc, PlaceState>(
          listener: (context, state) {
            if (state is PlaceFailure) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          child: BlocBuilder<PlaceBloc, PlaceState>(
            builder: (context, state) {
              if (state is PlaceInitial) {
                return _buildLoading();
              } else if (state is PlaceLoaded) {
                return _buildLoaded(context, state.place);
              } else if (state is PlaceFailure) {
                return Container();
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoaded(BuildContext context, Place place) {
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
                          Navigator.pop(context);
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
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                child: Text(
                  place.name,
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
                child: Text(
                  '${place.quantity} dari ${place.capacity}',
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
                      ElevatedButton(
                          onPressed: () => {},
                          child: Text("CHECK-IN CONFIRMATION"),
                          style: ElevatedButton.styleFrom(
                            primary: Style.Colors.titleColor,
                            shape: StadiumBorder(),
                          ))
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

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
