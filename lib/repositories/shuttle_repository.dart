import 'package:limuny/model/ShuttleModel.dart';
import 'package:limuny/provider/shuttle_provider.dart';

class ShuttleRepository {
  final _shuttleProvide = ShuttleProvider();

  Future<List<Bus>> getShuttles(String start, String destination) {
    return _shuttleProvide.getShuttleFiltered(start, destination);
  }
}

class ShuttleNetworkError extends Error {}
