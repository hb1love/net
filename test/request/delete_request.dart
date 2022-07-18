import 'package:net/http_method.dart';
import 'package:net/net_request.dart';

class DeleteRequest extends NetRequest {
  String userId;

  DeleteRequest({this.userId = '2'});

  @override
  String get baseUrl => 'https://reqres.in/api';

  @override
  String get path => '/users/$userId';

  @override
  HttpMethod get method => HttpMethod.delete;
}
