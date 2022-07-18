//import 'package:flutter_test/flutter_test.dart';
//import 'package:http/http.dart';
//import 'package:mockito/annotations.dart';
//import 'package:mockito/mockito.dart';
//import 'package:net/http_method.dart';
//import 'package:net/interceptor.dart';
//import 'package:net/net_provider.dart';
//import 'package:net/net_request.dart';
//import 'package:net/net_response.dart';
//
//import 'net_provider_test.mocks.dart';
//
//@GenerateMocks([Client, NetRequest, NetResponse, Interceptor])
void main() {

}
//  late NetProvider netProvider;
//  late MockClient mockClient;
//  late MockNetRequest mockRequest;
//  late MockNetResponse mockResponse;
//  late MockInterceptor mockInterceptor;
//
//
//  setUp(() {
//    mockRequest = MockNetRequest();
//    mockResponse = MockNetResponse();
//    mockInterceptor = MockInterceptor();
//    mockClient = MockClient();
//    netProvider = NetProvider(List.empty(), mockClient);
//  });
//
//  group('response 잘 처리하나 테스트', () {
//
//    test('net response 잘 만듦?', () async {
//      // arrange
//      final url = Uri.parse('https://net.test/items');
//      when(mockRequest.uri).thenReturn(url);
//      when(mockRequest.method).thenReturn(HttpMethod.get);
//
//      final response = Response('{"data": "any data"}', 200);
//      when(mockClient.get(url)).thenAnswer((_) async => response);
//
//      final netResponse = NetResponse(response: response);
//
//      // act
//      final actual = await netProvider.send(mockRequest);
//
//      // assert
//      expect(actual, netResponse);
//    });
//  });
//
//  group('인터셉터 테스트', () {
////    late NetProvider netProvider;
////    late MockClient mockClient;
////    late MockNetRequest mockRequest;
////    late MockNetResponse mockResponse;
////    late MockInterceptor mockInterceptor;
////
////    setUp(() {
////      mockRequest = MockNetRequest();
////      mockResponse = MockNetResponse();
////      mockInterceptor = MockInterceptor();
////      mockClient = MockClient();
////      netProvider = NetProvider([], mockClient);
////    });
//
//    test('prepare', () async {
//      // arrange
////      final url = Uri.parse('https://net.test/items');
////      when(mockRequest.uri).thenReturn(url);
////      when(mockRequest.method).thenReturn(HttpMethod.get);
////
//////      when(mockInterceptor.prepare(any)).thenReturn(mockRequest);
//////      when(mockInterceptor.didReceive(any));
//////      when(mockInterceptor.process(any)).thenReturn(mockResponse);
////
////      final response = Response('{"data": "any data"}', 200);
////      when(mockClient.get(url)).thenAnswer((_) async => response);
////
////      final netResponse = NetResponse(response: response);
////
////      // act
////      final actual = await netProvider.send(mockRequest);
////
////      // assert
////      expect(actual, netResponse);
//
////      // act
////      final actual = await netProvider.send(mockRequest);
////
////      // assert
////      verify(mockInterceptor.prepare(mockRequest)).called(1);
////      expect();
//    });
//
//    test('didReceive', () {
//      // arrange
//
//      // act
//
//      // assert
//    });
//
//    test('process', () {
//      // arrange
//
//      // act
//
//      // assert
//    });
//  });
//
//  test('인터셉터', () {
//    // arrange
//
//    // act
//
//    // assert
//  });
//
////  test('returns net response if the http call completes', () async {
////    // arrange
////    const baseUrl = 'https://net.test';
////    const path = '/items';
////    final response = Response('{"data": "any data"}', 200);
////    final netResponse = NetResponse(response: response);
////    when(mockRequest.baseUrl).thenReturn(baseUrl);
////    when(mockRequest.path).thenReturn(path);
////    when(mockRequest.method).thenReturn(HttpMethod.get);
////    when(mockClient.get(Uri.parse(baseUrl + path)))
////        .thenAnswer((_) async => response);
////
////    // act
////    final actual = await netProvider.send(mockRequest);
////
////    // assert
////    expect(actual, netResponse);
////  });
//
////  test('returns movies if the http call completes successfully', () async {
////    // arrange
//////    final request = MoviesGetRequest();
////    final response = Response('{"data": [{ "id": 1, "title": "Iron man" }]}', 200);
////    final netResponse = NetResponse(response: response);
////    when(mockClient.get(Uri.parse(request.baseUrl + request.path)))
////        .thenAnswer((_) async => response);
////
////    // act
////    final actual = await netProvider.send(request);
////
////    // assert
////    expect(actual, netResponse);
////  });
//}
