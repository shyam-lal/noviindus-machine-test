class ApiRequest {
  ApiRequest({this.url, this.body, this.headers = const <String, String>{}});

  final Uri? url;
  final dynamic body;
  final Map<String, String>? headers;
}