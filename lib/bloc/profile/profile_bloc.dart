import 'package:bloc/bloc.dart';
import 'package:limuny/bloc/profile/profile_event.dart';
import 'package:limuny/bloc/profile/profile_state.dart';
import 'package:limuny/repositories/user_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository = UserRepository();

  @override
  // TODO: implement initialState
  ProfileState get initialState => ProfileInitial();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is GetProfile) {
      try {
        yield ProfileLoading();
        final _user = await _userRepository.getUser();
        yield ProfileLoaded(_user!);
      } on NetworkError {
        yield ProfileFailure(error: "Network Error");
      }
    }
  }
}
