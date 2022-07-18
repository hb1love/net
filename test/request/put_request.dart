import 'package:net/http_method.dart';
import 'package:net/net_request.dart';

class PutRequest extends NetRequest {
  String userId;

  PutRequest({this.userId = '2'});

  @override
  String get baseUrl => 'https://reqres.in/api';

  @override
  String get path => '/users/$userId';

  @override
  HttpMethod get method => HttpMethod.put;

  @override
  Map<String, dynamic> get body => {'name': 'morpheus', 'job': 'zion resident'};

  @override
  Map<String, dynamic> get headers => {'cache': false};
}
