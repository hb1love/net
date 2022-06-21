import 'package:http/http.dart';
import 'package:net/http_method.dart';
import 'package:net/interceptor.dart';
import 'package:net/net_request.dart';
import 'package:net/net_response.dart';

class NetProvider {
  final Client _client;
  final List<Interceptor> _interceptors;

  NetProvider(List<Interceptor> interceptors, [Client? client])
      : _client = client ?? Client(),
        _interceptors = interceptors;

  Future<NetResponse> send(NetRequest req) async {
    var request = _prepare(req);
    var url = Uri();

    late Response response;
    switch (request.method) {
      case HttpMethod.get:
        response = await _client.get(url);
        break;
    }
    var netResponse = NetResponse(response: response);
    _didReceive(netResponse);
    return _process(netResponse);
  }

  NetRequest _prepare(NetRequest originalRequest) {
    var request = originalRequest;
    for (var el in _interceptors) {
      request = el.prepare(request);
    }
    return request;
  }

  void _didReceive(NetResponse originalResponse) {
    for (var el in _interceptors) {
      el.didReceive(originalResponse);
    }
  }

  NetResponse _process(NetResponse originalResponse) {
    var response = originalResponse;
    for (var el in _interceptors) {
      response = el.process(response);
    }
    return response;
  }
}
