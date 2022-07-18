import 'package:net/http_method.dart';

abstract class NetRequest {
  String get baseUrl;

  String get path;

  HttpMethod get method;

  Map<String, dynamic> get headers => {};

  Map<String, dynamic> get body => {};

  Map<String, dynamic> get queryParameters => {};

  String get _queryParameters {
    if (queryParameters.isNotEmpty) {
      final jsonString = Uri(queryParameters: queryParameters);
      return '?${jsonString.query}';
    }
    return '';
  }

  Uri get uri => Uri.parse('$baseUrl$path$_queryParameters');
}
