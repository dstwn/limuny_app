import 'package:bloc/bloc.dart';
import 'package:limuny/bloc/place/place_state.dart';
import 'package:limuny/bloc/shuttle/shuttle_event.dart';
import 'package:limuny/bloc/shuttle/shuttle_state.dart';
import 'package:limuny/repositories/shuttle_repository.dart';
import 'package:limuny/repositories/user_repository.dart';

class ShuttleBloc extends Bloc<ShuttleEvent, ShuttleState> {
  late final ShuttleRepository _shuttleRepository;
  @override
  ShuttleState get initialState => const ShuttleInital();

  @override
  Stream<ShuttleState> mapEventToState(ShuttleEvent event) async* {
    if (event is GetShuttle) {
      try {
        yield ShuttleLoading();
        final _shuttle = await _shuttleRepository.getShuttles(
            event.start, event.destination);
        yield ShuttleLoaded(shuttle: _shuttle);
      } on OnNetworkError {
        yield const ShuttleFailure(error: "Network");
      }
    }
  }
}
