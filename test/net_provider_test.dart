//import 'package:flutter_test/flutter_test.dart';
//import 'package:http/http.dart';
//import 'package:mockito/annotations.dart';
//import 'package:mockito/mockito.dart';
//import 'package:net/interceptor.dart';
//import 'package:net/net_provider.dart';
//import 'package:net/net_request.dart';
//import 'package:net/net_response.dart';
//
//import 'net_provider_test.mocks.dart';
//import 'request/movies_get_request.dart';
//
//class MockRequest extends Mock implements NetRequest {}
//
////
//class MockInterceptor extends Mock implements Interceptor {
//  @override
//  NetRequest prepare(NetRequest? request) =>
//      super.noSuchMethod(Invocation.method(#prepare, [request]));
//}
//
//class MockResponse extends Mock implements Response {}
//
//@GenerateMocks([Client])
//void main() {
//  late MockClient client;
//  late NetProvider netProvider;
//  late MockInterceptor mockInterceptor;
//  late MockResponse mockResponse;
//  setUp(() {
//    mockInterceptor = MockInterceptor();
//    mockResponse = MockResponse();
//    client = MockClient();
//    netProvider = NetProvider(List.empty(), client);
//  });
//
//  test('new', () async {
//    // assign
//    final response = NetResponse(response: mockResponse);
//    final request = MoviesGetRequest();
//    when(client.get(request.baseUrl)).thenAnswer((_) async => Response('Not Found', 404));
//
//    // act
//    final result = await netProvider.send(request);
//
//    // assert
//    expect(result, response);
//  });
//}
