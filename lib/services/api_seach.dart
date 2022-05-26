import 'base_network_cari.dart';

class CovidDataSource {
  static CovidDataSource instance = CovidDataSource();
  Future<Map<String, dynamic>> loadCountries() {
    return BaseNetwork.get('laut');
  }
}
