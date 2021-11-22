import 'package:equatable/equatable.dart';

abstract class UserStatusEvent extends Equatable {
  const UserStatusEvent();
}

class GetUserStatus extends UserStatusEvent {
  @override
  List<Object>? get props => null;
}

class UserCheckOut extends UserStatusEvent {
  @override
  // TODO: implement props
  List<Object>? get props => null;
}
