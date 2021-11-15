import 'package:limuny/bloc/auth/auth.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:limuny/styles/theme.dart' as Style;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Style.Colors.colorWhite,
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://yt3.ggpht.com/yti/ANoDKi5R5eJSjZigdWmIcZKFAtqwG4svMcAAN0Iyvw4j=s108-c-k-c0x00ffffff-no-rj"),
            ),
          ),
          title: Text(
            "LIMUNY APPS",
            style: TextStyle(
                color: Style.Colors.mainColor,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  EvaIcons.logOutOutline,
                  color: Style.Colors.mainColor,
                ),
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(
                    LoggedOut(),
                  );
                })
          ],
        ),
        body: Center(
          child: Text("Main Screen"),
        ));
  }
}
