import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:limuny/bloc/place/history/history_bloc.dart';
import 'package:limuny/bloc/place/history/history_event.dart';
import 'package:limuny/bloc/place/history/history_state.dart';
import 'package:limuny/bloc/shuttle/history/shuttle_history_bloc.dart';
import 'package:limuny/bloc/shuttle/history/shuttle_history_event.dart';
import 'package:limuny/bloc/shuttle/history/shuttle_history_state.dart';
import 'package:limuny/model/PlaceHistoryModel.dart';
import 'package:limuny/model/ShuttleHistoryModel.dart';
import 'package:limuny/styles/theme.dart' as Style;

class ShuttelHistoryScreen extends StatefulWidget {
  const ShuttelHistoryScreen({Key? key}) : super(key: key);

  @override
  _ShuttleHistoryScreenState createState() => _ShuttleHistoryScreenState();
}

class _ShuttleHistoryScreenState extends State<ShuttelHistoryScreen> {
  final ShuttleHistoryBloc _shuttleHistoryBloc = ShuttleHistoryBloc();

  @override
  void initState() {
    _shuttleHistoryBloc.add(GetShuttleHistory());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        title: Text("Place History"),
      ),
      body: _buildPlaceHistory(),
    );
  }

  Widget _buildPlaceHistory() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _shuttleHistoryBloc,
        child: BlocListener<ShuttleHistoryBloc, ShuttleHistoryState>(
          listener: (context, state) {
            if (state is ShuttleHistoryFailure) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
          },
          child: BlocBuilder<ShuttleHistoryBloc, ShuttleHistoryState>(
            builder: (context, state) {
              if (state is ShuttleHistoryInitial) {
                return _buildLoading();
              } else if (state is ShuttleHistoryLoading) {
                return _buildLoading();
              } else if (state is ShuttleHistoryLoaded) {
                return _buildHistoryLoaded(context, state.history);
              } else if (state is ShuttleHistoryFailure) {
                return Container();
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryLoaded(
      BuildContext context, List<BusItem> placeHistoryModel) {
    return ListView.builder(
      itemCount: placeHistoryModel.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(8.0),
          child: Card(
            child: Container(
              margin: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text("Code : ${placeHistoryModel[index].code}"),
                  Text("Destination : ${placeHistoryModel[index].destination}"),
                  Text("Check-In : ${placeHistoryModel[index].checkInTime}"),
                  Text("Check-Out: ${placeHistoryModel[index].checkOutTime}")
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
