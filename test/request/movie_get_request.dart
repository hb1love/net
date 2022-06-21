import 'package:net/content_encoding.dart';
import 'package:net/http_method.dart';
import 'package:net/net_request.dart';

class MovieGetRequest extends NetRequest {
  final String id;

  MovieGetRequest(this.id);

  @override
  String get baseUrl => 'https://demo5765241.mockable.io';

  @override
  String get path => '/movies/$id';

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
