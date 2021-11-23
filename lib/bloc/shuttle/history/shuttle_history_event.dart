import 'package:equatable/equatable.dart';

abstract class ShuttleHistoryEvent extends Equatable {
  const ShuttleHistoryEvent();
}

class GetShuttleHistory extends ShuttleHistoryEvent {
  @override
  // TODO: implement props
  List<Object>? get props => null;
}
