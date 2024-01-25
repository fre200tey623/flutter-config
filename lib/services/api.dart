import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class MyHttp extends http.BaseClient {
  final http.Client _inner = http.Client();

  String? token;

  void setToken(String token) {
    this.token = token;
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    request.headers['Content-Type'] = 'application/json';
    request.headers['Accept'] = 'application/json';
    request.headers['token'] = token ?? '';

    return _inner.send(request);
  }

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    final response = await _inner.get(url, headers: headers);
    return response;
  }

  @override
  Future<http.Response> post(Uri url,
      {Map<String, String>? headers, dynamic body, Encoding? encoding}) async {
    final requestBody = jsonEncode(body);
    final response = await _inner.post(
      url,
      headers: headers,
      body: requestBody,
    );
    return response;
  }

  @override
  Future<http.Response> put(Uri url,
      {Map<String, String>? headers, dynamic body, Encoding? encoding}) async {
    final requestBody = jsonEncode(body);
    final response = await _inner.put(
      url,
      headers: headers,
      body: requestBody,
    );
    return response;
  }

  @override
  Future<http.Response> delete(Uri url,
      {Map<String, String>? headers, dynamic body, Encoding? encoding}) async {
    final requestBody = jsonEncode(body);
    final response = await _inner.delete(
      url,
      headers: headers,
      body: requestBody,
    );
    return response;
  }
}

Uri getApiUrl(endpoint) {
  return Uri.parse("http://10.148.9.5:8001/api$endpoint");
}
