import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:limuny/bloc/place/place_bloc.dart';
import 'package:limuny/bloc/place/place_event.dart';
import 'package:limuny/bloc/place/place_state.dart';
import 'package:limuny/model/CheckInModel.dart';
import 'package:limuny/model/CheckOutModel.dart';
import 'package:limuny/model/PlaceModel.dart';
import 'package:limuny/styles/animation.dart';
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
                //return _buildLoaded(context, state.place);
                return _newCheckInLoaded(context, state.place);
              } else if (state is PlaceFailure) {
                return Container();
              } else if (state is CheckInInitial) {
                return _buildLoading();
              } else if (state is CheckInLoaded) {
                return _checkInLoaded(context, state.checkin);
              } else if (state is CheckOutInitial) {
                return _buildLoading();
              } else if (state is CheckOutLoading) {
                return _buildLoading();
              } else if (state is CheckOutLoaded) {
                return _checkOutLoaded(context, state.checkOutModel);
              }
              return _buildLoading();
            },
          ),
        ),
      ),
    );
  }

  Widget _newCheckInLoaded(BuildContext context, Place place) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            //height: 500,
            child: FadeAnimation(
              1.2,
              Container(
                  //padding: const EdgeInsets.all(30),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      colors: [
                        Style.Colors.facebookBlue,
                        Style.Colors.mainColor,
                      ],
                    ),
                  ),
                  child: FadeAnimation(
                      1.3,
                      CachedNetworkImage(
                        imageUrl: place.place_image,
                        fit: BoxFit.fill,
                        placeholder: (context, url) =>
                            new CircularProgressIndicator(
                          color: Style.Colors.colorWhite,
                        ),
                        errorWidget: (context, url, error) =>
                            new Icon(Icons.error),
                      ))),
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
                          place.type,
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
                          'Kuota ${place.quantity}/${place.capacity}',
                          style: GoogleFonts.poppins(
                            color: const Color.fromRGBO(51, 51, 51, .54),
                            fontSize: 18,
                            height: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      FadeAnimation(
                          1.5,
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<PlaceBloc>(context)
                                  .add(CheckIn(uuid: place.uuid));
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
                                        'Kuota ${place.quantity}/${place.capacity} ',
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
                                    'Check-In',
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

  Widget _checkOutLoaded(BuildContext context, CheckOutModel checkOutModel) {
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
                  checkOutModel.status,
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
                    checkOutModel.message,
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
              // Expanded(
              //   child: Padding(
              //     padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 32),
              //     child: Column(
              //       mainAxisSize: MainAxisSize.max,
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       children: [
              //         ElevatedButton(
              //             onPressed: () => {
              //                   BlocProvider.of<PlaceBloc>(context)
              //                       .add(CheckOut()),
              //                 },
              //             child: Text("CHECK-OUT"),
              //             style: ElevatedButton.styleFrom(
              //               elevation: 0,
              //               primary: Style.Colors.successGreen,
              //               shape: StadiumBorder(),
              //             ))
              //       ],
              //     ),
              //   ),
              // )
            ],
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
                      Icons.add_location_outlined,
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
                child: Chip(
                  labelPadding: EdgeInsets.all(2.0),
                  label: Text(
                    place.type,
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
                          onPressed: () => {
                                BlocProvider.of<PlaceBloc>(context)
                                    .add(CheckIn(uuid: place.uuid))
                              },
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
  Widget _checkInLoaded(BuildContext context, CheckInModel checkin) {
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
                  checkin.name,
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
                    checkin.activity_category,
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
                  '${checkin.quantity} dari ${checkin.capacity}',
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
                          onPressed: () => {
                                BlocProvider.of<PlaceBloc>(context)
                                    .add((CheckOut()))
                              },
                          child: Text("CHECK-OUT"),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: Style.Colors.successGreen,
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
}
