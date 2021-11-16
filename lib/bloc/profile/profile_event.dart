import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class GetProfile extends ProfileEvent {
  @override
  // TODO: implement props
  List<Object>? get props => null;
}
