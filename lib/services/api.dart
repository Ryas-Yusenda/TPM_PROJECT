import 'base_network.dart';

class NewsDataSource {
  static NewsDataSource instance = NewsDataSource();
  Future<Map<String, dynamic>> loadNews(path) {
    return BaseNetwork.get(path);
  }
}
