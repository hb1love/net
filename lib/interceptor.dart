import 'package:net/net_response.dart';
import 'package:net/net_request.dart';

abstract class Interceptor {
  /// Called to modify a request before sending.
  NetRequest prepare(NetRequest request);

  /// Called after a response has been received, but before the Provider has invoked its completion handler.
  void didReceive(NetResponse response);

  /// Called to modify a result before completion.
  NetResponse process(NetResponse response);
}
