import 'package:net/content_encoding.dart';
import 'package:net/http_header.dart';
import 'package:net/http_method.dart';

abstract class NetRequest {
  final List<HttpHeader> _additionalHeaders = [];

  String get baseUrl;

  String get path;

  HttpMethod get method;

  Map<String, String> get headers;

  Map<String, String> get allHeaders {
    Map<String, String> allHeaders = headers;
    var additionalHeadersMap = {
      for (var e in _additionalHeaders) e.key: e.value
    };
    allHeaders.addAll(additionalHeadersMap);
    return allHeaders;
  }

  Map<String, dynamic> get parameters;

  ContentEncoding get contentEncoding;

  String get queryParameters {
    if (method == HttpMethod.get && parameters.isNotEmpty) {
      final jsonString = Uri(queryParameters: parameters);
      return '?${jsonString.query}';
    }

    return '';
  }

  void putAdditionalHeader(HttpHeader header) {
    _additionalHeaders.add(header);
  }
}
