import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  final String urlBase;

  Api(this.urlBase);

  Future<dynamic> get(String uri, {Map<String, String> headers}) async {
    try {
      http.Response response = await http.get(uri, headers: {});

      final statusCode = response.statusCode;
      final String jsonBody = response.body;

      if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
        throw new FetchDataException("Error request:", statusCode);
      }

      const JsonDecoder decoder = const JsonDecoder();
      return decoder.convert(response.body);
    } on Exception catch (e) {
      throw new FetchDataException(e.toString(), 0);
    }
  }
}

class FetchDataException implements Exception {
  String _message;
  int _code;

  FetchDataException(this._message, this._code);

  String toString() {
    return "Exception: $_message/$_code";
  }

  int code() {
    return _code;
  }
}
