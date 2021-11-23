import 'package:bloc/bloc.dart';
import 'package:limuny/bloc/shuttle/history/shuttle_history_event.dart';
import 'package:limuny/bloc/shuttle/history/shuttle_history_state.dart';
import 'package:limuny/model/ShuttleHistoryModel.dart';
import 'package:limuny/repositories/shuttle_repository.dart';

class ShuttleHistoryBloc
    extends Bloc<ShuttleHistoryEvent, ShuttleHistoryState> {
  final ShuttleRepository _shuttleRepository = ShuttleRepository();

  @override
  ShuttleHistoryState get initialState => const ShuttleHistoryInitial();

  @override
  Stream<ShuttleHistoryState> mapEventToState(
      ShuttleHistoryEvent event) async* {
    if (event is GetShuttleHistory) {
      try {
        yield ShuttleHistoryLoading();
        List<BusItem> _place = await _shuttleRepository.getHistoryShuttle();
        yield ShuttleHistoryLoaded(history: _place);
      } catch (err) {
        yield const ShuttleHistoryFailure(error: "err");
      }
    }
  }
}
