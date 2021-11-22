import 'package:equatable/equatable.dart';

abstract class PlaceHistoryEvent extends Equatable {
  const PlaceHistoryEvent();
}

class GetPlaceHistory extends PlaceHistoryEvent {
  @override
  // TODO: implement props
  List<Object>? get props => null;
}
