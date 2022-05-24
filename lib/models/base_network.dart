import 'dart:convert';
import 'package:http/http.dart' as http;

class BaseNetwork {
  static List<String> listSource = [
    "antara",
    "cnbc",
    "cnn",
    "jpnn",
    "kumparan",
    "merdeka",
    "okezone",
    "republika",
    "sindonews",
    "suara",
    "tempo",
    "tribun",
  ];

  static const String baseUrl = "https://api-berita-indonesia.vercel.app/";

  static Future<Map<String, dynamic>> get(String partUrl) async {
    final String fullUrl = baseUrl + "/" + listSource[11] + "/" + partUrl;
    debugPrint("BaseNetwork - fullUrl : $fullUrl");
    final response = await http.get(Uri.parse(fullUrl));
    debugPrint("BaseNetwork - response : ${response.body}");
    return _processResponse(response);
  }

  static Future<Map<String, dynamic>> _processResponse(
      http.Response response) async {
    final body = response.body;
    if (body.isNotEmpty) {
      final jsonBody = json.decode(body);
      return jsonBody;
    } else {
      print("processResponse error");
      return {"error": true};
    }
  }

  static void debugPrint(String value) {
    print("[BASE_NETWORK] - $value");
  }
}
