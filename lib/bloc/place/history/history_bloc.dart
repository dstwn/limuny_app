import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:limuny/bloc/place/history/history_event.dart';
import 'package:limuny/bloc/place/history/history_state.dart';
import 'package:limuny/model/PlaceHistoryModel.dart';
import 'package:limuny/repositories/user_repository.dart';

class PlaceHistoryBloc extends Bloc<PlaceHistoryEvent, PlaceHistoryState> {
  final UserRepository _userRepository = UserRepository();

  @override
  PlaceHistoryState get initialState => const PlaceHistoryInitial();

  @override
  Stream<PlaceHistoryState> mapEventToState(PlaceHistoryEvent event) async* {
    if (event is GetPlaceHistory) {
      try {
        yield PlaceHistoryLoading();
        List<Datum> _place = await _userRepository.getHistoryPlace();
        yield PlaceHistoryLoaded(history: _place);
      } on UserNetworkError {
        yield const PlaceHistoryFailure(error: "error");
      }
    }
  }
}
