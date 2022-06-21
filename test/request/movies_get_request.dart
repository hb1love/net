import 'package:net/content_encoding.dart';
import 'package:net/http_method.dart';
import 'package:net/net_request.dart';

class MoviesGetRequest extends NetRequest {
  MoviesGetRequest();

  @override
  String get baseUrl => 'https://my.domain';

  @override
  String get path => '/movies';

  @override
  ContentEncoding get contentEncoding => ContentEncoding.url;

  @override
  Map<String, String> get headers => {
        "content-type": "application/json",
        "accept": "*/*",
      };

  @override
  HttpMethod get method => HttpMethod.get;

  @override
  Map<String, dynamic> get parameters => {};
}
