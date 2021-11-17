import 'package:limuny/model/CheckInModel.dart';
import 'package:limuny/model/PlaceModel.dart';
import 'package:limuny/provider/place_provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class PlaceRepository {
  final _placeProvider = PlaceProvider();
  Future<Place>? getPlace(String uuid) {
    return _placeProvider.fecthPlace(uuid);
  }

  Future<CheckInModel>? checkIn(String uuid) {
    return _placeProvider.checkIn(uuid);
  }
}

class NetworkError extends Error {}
