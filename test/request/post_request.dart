import 'package:net/http_method.dart';
import 'package:net/net_request.dart';

class PostRequest extends NetRequest {
  @override
  String get baseUrl => 'https://reqres.in/api';

  @override
  String get path => '/users';

  @override
  HttpMethod get method => HttpMethod.post;

  @override
  Map<String, dynamic> get queryParameters => {'page': '2'};

  @override
  Map<String, dynamic> get body => {'name': 'morpheus', 'job': 'leader'};
}
