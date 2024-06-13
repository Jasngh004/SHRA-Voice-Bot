import 'package:http/http.dart' as http;

  Future<http.Response> getRequest(url) async {
    final response = await http.get(Uri.parse(url),);
    return response;
  }