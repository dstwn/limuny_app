import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:limuny/styles/theme.dart' as Style;
import 'package:limuny/ui/shuttle/shuttle_filter_screen.dart';
import 'package:limuny/ui/shuttle/shuttle_history_screen.dart';

import 'checkin/shuttle_scanner_screen.dart';

class ShuttleScreen extends StatefulWidget {
  const ShuttleScreen({Key? key}) : super(key: key);

  @override
  _ShuttleScreenState createState() => _ShuttleScreenState();
}

class _ShuttleScreenState extends State<ShuttleScreen> {
  List _shuttle = ['Karang Malang', 'Wates', 'Gunungkidul'];
  var _start;
  var _destination;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Style.Colors.mainColor,
          title: Text("Shuttle Bus"),
          automaticallyImplyLeading: true,
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
                          builder: (context) => ShuttelHistoryScreen()));
                }),
          ],
        ),
      ),
      body: _buildHomeMenus(),
    );
  }

  Widget _buildHomeMenus() {
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
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: Style.Colors.colorWhite,
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(14, 14, 14, 14),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-1, -1),
                              child: Text(
                                'Mau Naik Shuttle ?',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: RaisedButton(
                                  child: Text('Chek-In'),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (context) =>
                                          CheckInShuttleScanner(),
                                    ));
                                  },
                                )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Style.Colors.colorWhite,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(14, 14, 14, 14),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1, -1),
                          child: Text(
                            'Cari Bus',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            Container(
                              height: 56,
                              width: double.infinity,
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                color: Style.Colors.textWhiteGrey,
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: Text("Dari"),
                                  value: _start,
                                  items: _shuttle.map((value) {
                                    return DropdownMenuItem(
                                        child: Text(value), value: value);
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _start = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            Container(
                                height: 56,
                                width: double.infinity,
                                padding: const EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                  color: Style.Colors.textWhiteGrey,
                                  borderRadius: BorderRadius.circular(14.0),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    hint: Text("Tujuan"),
                                    value: _destination,
                                    items: _shuttle.map((value) {
                                      return DropdownMenuItem(
                                          child: Text(value), value: value);
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _destination = value;
                                      });
                                    },
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Material(
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
                                    borderRadius: BorderRadius.circular(14.0)),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) => ShuttleFilterScreen(
                                      start: _start,
                                      destination: _destination,
                                    ),
                                  ));
                                },
                                child: Center(
                                  child: Text(
                                    "Cari Shuttle",
                                    style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600)
                                        .copyWith(
                                            color: Style.Colors.colorWhite),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // decoration: new BoxDecoration(
                //   boxShadow: [
                //     new BoxShadow(
                //       color: Style.Colors.greyBack,
                //       blurRadius: 0.0,
                //     ),
                //   ],
                // ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
