import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:limuny/bloc/auth/auth_bloc.dart';
import 'package:limuny/bloc/auth/auth_event.dart';
import 'package:limuny/bloc/profile/profile_bloc.dart';
import 'package:limuny/bloc/profile/profile_event.dart';
import 'package:limuny/bloc/profile/profile_state.dart';
import 'package:limuny/model/UserModel.dart';
import 'package:limuny/styles/theme.dart' as Style;

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileBloc profileBloc = ProfileBloc();
  @override
  void initState() {
    profileBloc.add(GetProfile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        title: Text("Profile"),
        actions: [
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
      body: _buildProfile(),
    );
  }

  Widget _buildProfile() {
    return Container(
      child: BlocProvider(
        create: (_) => profileBloc,
        child: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileFailure) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
          },
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileInitial) {
                return _buildLoading();
              } else if (state is ProfileLoading) {
                return _buildLoading();
              } else if (state is ProfileLoaded) {
                return _buildLoaded(context, state.user);
              } else if (state is ProfileFailure) {
                return Container();
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
  Widget _buildLoaded(BuildContext context, User user) {
    return Center(
      child: Text(
          "nama : ${user.name}, email : ${user.email}, nim : ${user.nim}, nik: ${user.nik}, phone : ${user.phone}, major : ${user.major}"),
    );
  }
}
