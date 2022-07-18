import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:net/http_method.dart';
import 'package:net/net_exception.dart';
import 'package:net/net_provider.dart';
import 'package:net/net_request.dart';

import 'net_provider_test.mocks.dart';
import 'request/delete_request.dart';
import 'request/get_request.dart';
import 'request/post_request.dart';
import 'request/put_request.dart';
import 'response_model.dart';

@GenerateMocks([NetRequest, Dio, DioError, Response])
void main() {
  late NetProvider provider;
  late MockDio mockDio;
  late MockNetRequest mockNetRequest;
  late MockDioError mockDioError;
  late MockResponse mockResponse;
  late Uri mockUri;
  late Map<String, dynamic> resultData;

  setUp(() {
    mockDio = MockDio();
    when(mockDio.options).thenReturn(BaseOptions());
    when(mockDio.httpClientAdapter).thenReturn(DefaultHttpClientAdapter());
    when(mockDio.interceptors).thenReturn(Interceptors());

    mockNetRequest = MockNetRequest();
    mockDioError = MockDioError();
    mockResponse = MockResponse();
    provider = NetProvider(mockDio, interceptors: []);
    mockUri =
        Uri.parse('https://m-wing.coupang.com/wing-mapi/v1/endpoints/intro');
    resultData = {};
  });

  expectRequestThrowsOf(Matcher matcher) {
    expect(
        () async => {
              // act
              await provider.send<ResponseModel>(
                  mockNetRequest, (json) => ResponseModel.fromJson(json))
            },
        throwsA(matcher));
  }

  group('response parsing', () {
    setUp(() {
      when(mockNetRequest.uri).thenReturn(mockUri);
      when(mockNetRequest.method).thenReturn(HttpMethod.get);
      when(mockNetRequest.headers).thenReturn({});
      when(mockNetRequest.body).thenReturn({});
      when(mockDio.requestUri(any,
              data: anyNamed('data'), options: anyNamed('options')))
          .thenAnswer((_) => Future.value(mockResponse));
    });

    test('should return value of the passed type', () async {
      // arrange
      String id = '1';
      String title = 'test';
      resultData = {'id': id, 'title': title};
      when(mockResponse.data).thenReturn(resultData);

      // act
      var actual = await provider.send<ResponseModel>(
          mockNetRequest, (json) => ResponseModel.fromJson(json));

      // assert
      expect(actual, ResponseModel(id, title));
    });

    test('should throw exception if rData is empty', () async {
      // arrange
      resultData = {};
      when(mockResponse.data).thenReturn(resultData);

      // assert
      expectRequestThrowsOf(isA<NetException>());
    });
  });

  runTestsDioErrorTypeIsResponse(Function body) {
    group("the dio error is 'response' type", () {
      setUp(() {
        when(mockDioError.type).thenReturn(DioErrorType.response);
        when(mockDioError.response).thenReturn(mockResponse);
      });

      body();
    });
  }

  group('exception handling', () {
    setUp(() {
      when(mockNetRequest.uri).thenReturn(mockUri);
      when(mockNetRequest.method).thenReturn(HttpMethod.get);
      when(mockNetRequest.headers).thenReturn({});
      when(mockNetRequest.body).thenReturn({});
    });

    group('dio error', () {
      setUp(() {
        when(mockDio.requestUri(any,
                data: anyNamed('data'), options: anyNamed('options')))
            .thenThrow(mockDioError);
      });

      test(
          "should throw timeout exception if error type falls under any of ['receiveTimeout', 'connectTimeout', 'sendTimeout']",
          () async {
        when(mockDioError.type).thenReturn(DioErrorType.receiveTimeout);
        expectRequestThrowsOf(isA<RequestTimeout>());

        when(mockDioError.type).thenReturn(DioErrorType.connectTimeout);
        expectRequestThrowsOf(isA<RequestTimeout>());

        when(mockDioError.type).thenReturn(DioErrorType.sendTimeout);
        expectRequestThrowsOf(isA<RequestTimeout>());
      });

      runTestsDioErrorTypeIsResponse(() {
        test('should throw bad request exception if response status is 400',
            () async {
          // arrange
          when(mockResponse.statusCode).thenReturn(400);

          // assert
          expectRequestThrowsOf(isA<BadRequest>());
        });

        test(
            'should throw internal server error exception if response status is 500',
            () async {
          // arrange
          when(mockResponse.statusCode).thenReturn(500);

          // assert
          expectRequestThrowsOf(isA<InternalServerError>());
        });

        test(
            'should throw default exception if response status is not processable',
            () async {
          // arrange
          when(mockResponse.statusCode).thenReturn(408);

          // assert
          expectRequestThrowsOf(isA<DefaultError>());
        });
      });
    });
  });

  group('request model', () {
    setUp(() {
      provider = NetProvider(Dio(), interceptors: []);
    });

    group('get request', () {
      test(
          'should return the combination of baseUrl, path and query parameters to uri',
          () async {
        // arrange
        var request = GetRequest();

        // act
        var actual = await provider.request(request);

        // assert
        expect(actual.realUri, request.uri);
      });
    });

    group('post request', () {
      late PostRequest request;
      setUp(() {
        // arrange
        request = PostRequest();
      });

      test('should return the combination of baseUrl and path to uri',
          () async {
        // act
        var actual = await provider.request(request);

        // assert
        expect(actual.realUri, request.uri);
      });

      test('does not include query parameters', () async {
        // act
        var actual = await provider.request(request);

        // assert
        expect(actual.requestOptions.queryParameters, {});
      });

      test('does include body parameters', () async {
        // act
        var actual = await provider.request(request);

        // assert
        expect(actual.requestOptions.data, request.body);
      });
    });

    test('put request', () async {
      // arrange
      var request = PutRequest();

      // act
      var actual = await provider.request(request);

      // assert
      expect(actual.requestOptions.queryParameters, {});
      expect(actual.requestOptions.data, request.body);
    });

    test('delete request', () async {
      // arrange
      var request = DeleteRequest();

      // act
      var actual = await provider.request(request);

      // assert
      expect(actual.requestOptions.queryParameters, {});
      expect(actual.requestOptions.data, request.body);
    });
  });
}
