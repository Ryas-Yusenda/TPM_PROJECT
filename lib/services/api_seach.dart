import 'base_network_cari.dart';

class CovidDataSource {
  static CovidDataSource instance = CovidDataSource();
  static Future<Map<String, dynamic>> loadCountries(String partUrl) async {
    return BaseNetwork.get(partUrl);
  }
}
