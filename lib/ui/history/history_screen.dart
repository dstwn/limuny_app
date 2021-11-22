import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:limuny/bloc/place/history/history_bloc.dart';
import 'package:limuny/bloc/place/history/history_event.dart';
import 'package:limuny/bloc/place/history/place_state.dart';
import 'package:limuny/model/PlaceHistoryModel.dart';

class PlaceHistoryScreen extends StatefulWidget {
  const PlaceHistoryScreen({Key? key}) : super(key: key);

  @override
  _PlaceHistoryScreenState createState() => _PlaceHistoryScreenState();
}

class _PlaceHistoryScreenState extends State<PlaceHistoryScreen> {
  final PlaceHistoryBloc _placeHistoryBloc = PlaceHistoryBloc();

  @override
  void initState() {
    _placeHistoryBloc.add(GetPlaceHistory());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Place History"),
      ),
      body: _buildPlaceHistory(),
    );
  }

  Widget _buildPlaceHistory() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _placeHistoryBloc,
        child: BlocListener<PlaceHistoryBloc, PlaceHistoryState>(
          listener: (context, state) {
            if (state is PlaceHistoryFailure) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
          },
          child: BlocBuilder<PlaceHistoryBloc, PlaceHistoryState>(
            builder: (context, state) {
              if (state is PlaceHistoryInitial) {
                return _buildLoading();
              } else if (state is PlaceHistoryLoading) {
                return _buildLoading();
              } else if (state is PlaceHistoryLoaded) {
                return _buildHistoryLoaded(context, state.history);
              } else if (state is PlaceHistoryFailure) {
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
      BuildContext context, List<Datum> placeHistoryModel) {
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
                  Text("Country: ${placeHistoryModel[index].name}"),
                  Text("Country: ${placeHistoryModel[index].type}"),
                  Text("Country: ${placeHistoryModel[index].checkInTime}"),
                  Text("Country: ${placeHistoryModel[index].checkOutTime}")
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
