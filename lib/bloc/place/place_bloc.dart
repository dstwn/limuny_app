import 'package:bloc/bloc.dart';
import 'package:limuny/bloc/place/place_event.dart';
import 'package:limuny/bloc/place/place_state.dart';
import 'package:limuny/model/PlaceModel.dart';
import 'package:limuny/repositories/place_repository.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final PlaceRepository _placeRepository = PlaceRepository();
  @override
  PlaceState get initialState => PlaceInitial();

  @override
  Stream<PlaceState> mapEventToState(PlaceEvent event) async* {
    if (event is GetPlace) {
      try {
        yield PlaceLoading();
        final _place = await _placeRepository.getPlace(event.uuid);
        yield PlaceLoaded(_place!);
      } on NetworkError {
        yield PlaceFailure(error: "Network Error");
      }
    }
  }
}
