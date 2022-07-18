import 'package:dio/dio.dart';
import 'package:net/net_exception.dart';
import 'package:net/net_request.dart';

class NetProvider {
  static int connectTimeout = 5000;
  static int receiveTimeout = 3000;

  late final Dio _dio;

  NetProvider(Dio? dio, {required List<Interceptor> interceptors}) {
    _dio = dio ?? Dio()
      ..options.connectTimeout = connectTimeout
      ..options.receiveTimeout = receiveTimeout
      ..httpClientAdapter
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'accept': '*/*'
      };
    if (interceptors.isNotEmpty) {
      _dio.interceptors.addAll(interceptors);
    }
  }

  Future<T> send<T>(NetRequest netRequest,
      T Function(Map<String, dynamic> fromJsonT)? fromJsonT) async {
    try {
      var response = await request(netRequest);
      return fromJsonT != null
          ? fromJsonT(response.data as Map<String, dynamic>)
          : response.data;
    } catch (e) {
      throw NetException.fromObj(e);
    }
  }

  Future<Response> request(NetRequest request) async {
    return await _dio.requestUri(request.uri,
        data: _getData(request), options: _getOptions(request));
  }

  dynamic _getData(NetRequest request) => request.body;

  Options _getOptions(NetRequest request) => Options(
      method: request.method.value,
      headers: request.headers,
      validateStatus: (status) {
        return status != null ? status < 400 : false;
      });
}
