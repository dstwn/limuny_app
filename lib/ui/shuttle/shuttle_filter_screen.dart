import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:limuny/bloc/place/history/history_bloc.dart';
import 'package:limuny/bloc/place/history/history_event.dart';
import 'package:limuny/bloc/place/history/history_state.dart';
import 'package:limuny/bloc/shuttle/shuttle_bloc.dart';
import 'package:limuny/bloc/shuttle/shuttle_event.dart';
import 'package:limuny/bloc/shuttle/shuttle_state.dart';
import 'package:limuny/model/PlaceHistoryModel.dart';
import 'package:limuny/model/ShuttleModel.dart';

class ShuttleFilterScreen extends StatefulWidget {
  final String start;
  final String destination;
  const ShuttleFilterScreen(
      {Key? key, required this.start, required this.destination})
      : super(key: key);

  @override
  _ShuttleFilterScreenState createState() => _ShuttleFilterScreenState();
}

class _ShuttleFilterScreenState extends State<ShuttleFilterScreen> {
  final ShuttleBloc _shuttleBloc = ShuttleBloc();

  @override
  void initState() {
    _shuttleBloc
        .add(GetShuttle(start: widget.start, destination: widget.destination));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shuttle Bus"),
      ),
      body: _buildPlaceHistory(),
    );
  }

  Widget _buildPlaceHistory() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _shuttleBloc,
        child: BlocListener<ShuttleBloc, ShuttleState>(
          listener: (context, state) {
            if (state is ShuttleFailure) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
          },
          child: BlocBuilder<ShuttleBloc, ShuttleState>(
            builder: (context, state) {
              if (state is ShuttleInital) {
                return _buildLoading();
              } else if (state is ShuttleLoading) {
                return _buildLoading();
              } else if (state is ShuttleLoaded) {
                return _buildHistoryLoaded(context, state.shuttle);
              } else if (state is ShuttleFailure) {
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
      BuildContext context, List<Bus> placeHistoryModel) {
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
                  Text("From : ${placeHistoryModel[index].start}"),
                  Text(
                      "Departure Time: ${placeHistoryModel[index].departureTime}")
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
