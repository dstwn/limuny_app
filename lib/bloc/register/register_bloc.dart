import 'package:bloc/bloc.dart';
import 'package:limuny/bloc/auth/auth.dart';
import 'package:limuny/bloc/auth/auth_bloc.dart';
import 'package:limuny/bloc/register/register_event.dart';
import 'package:limuny/bloc/register/register_state.dart';
import 'package:limuny/repositories/user_repositories.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;
  RegisterBloc({required this.userRepository, required this.authenticationBloc})
      : assert(userRepository != null),
        assert(authenticationBloc != null);
  @override
  RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterButtonPressed) {
      yield RegisterLoading();
      try {
        final token = await userRepository.register(
            event.name,
            event.email,
            event.password,
            event.password_c,
            event.nim,
            event.nik,
            event.major,
            event.phone);
        authenticationBloc.add(LoggedIn(token: token));
        yield RegisterInitial();
      } catch (error) {
        yield RegisterFailure(error: error.toString());
      }
    }
  }
}
