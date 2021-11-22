import 'package:bloc/bloc.dart';
import 'package:limuny/bloc/user/user_event.dart';
import 'package:limuny/bloc/user/user_state.dart';
import 'package:limuny/repositories/user_repository.dart';

class UserStatusBloc extends Bloc<UserStatusEvent, UserStatusState> {
  final UserRepository _userRepository = UserRepository();

  @override
  // TODO: implement initialState
  UserStatusState get initialState => UserStatusInitial();

  @override
  Stream<UserStatusState> mapEventToState(UserStatusEvent event) async* {
    if (event is GetUserStatus) {
      try {
        yield UserStatusLoading();
        final _user = await _userRepository.getStatusUser();
        yield UserStatusLoaded(_user!);
      } on NetworkError {
        yield UserStatusFailure(error: "Network Error");
      }
    } else if (event is UserCheckOut) {
      try {
        yield UserCheckOutLoading();
        final _checkOut = await _userRepository.checkOut();
        yield UserCheckOutLoaded(_checkOut!);
      } on NetworkError {
        yield UserCheckOutFailure(error: "Failed CheckOut");
      }
    }
  }
}
