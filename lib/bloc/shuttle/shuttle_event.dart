import 'package:equatable/equatable.dart';

abstract class ShuttleEvent extends Equatable {
  const ShuttleEvent();
}

class GetShuttle extends ShuttleEvent {
  final String start;
  final String destination;

  const GetShuttle({required this.start, required this.destination});
  @override
  // TODO: implement props
  List<Object> get props => [start, destination];
  @override
  String toString() =>
      'Get Shuttle Log { start: $start, destination: $destination }';
}

class GetDetailShuttle extends ShuttleEvent {
  final String uuid;
  const GetDetailShuttle({required this.uuid});
  @override
  // TODO: implement props
  List<Object>? get props => [uuid];
}
