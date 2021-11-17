import 'package:equatable/equatable.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

abstract class PlaceEvent extends Equatable {
  const PlaceEvent();
}

class GetPlace extends PlaceEvent {
  final String uuid;
  const GetPlace({required this.uuid});
  @override
  // TODO: implement props
  List<Object>? get props => [uuid];
}
