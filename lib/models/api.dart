import 'base_network.dart';

class CovidDataSource {
  static CovidDataSource instance = CovidDataSource();
  Future<Map<String, dynamic>> loadCountries(path) {
    return BaseNetwork.get(path);
  }
}
