// import 'dart:convert';

// import 'package:core/logging/logger.dart';
// import 'package:core/storage/secure_storage/secure_storage_service.dart';
// import 'package:flutter/services.dart';
// import 'package:network_manager/auth/auth_manager.dart';
// import 'package:network_manager/client/network_client.dart';
// import 'package:network_manager/configuration/config.dart';
// import 'package:network_manager/global_control/global_control_notifier.dart';
// import 'package:network_manager/global_control/model/client_information/client_information.dart';
// import 'package:network_manager/global_control/model/configuration/config.dart';
// import 'package:network_manager/model/requests/graph_ql/base_data_model.dart';
// import 'package:network_manager/model/requests/graph_ql/graphql_request.dart';
// import 'package:network_manager/model/requests/base_request.dart';
// import 'package:network_manager/model/requests/standard/standard_request.dart';
// import 'package:network_manager/model/status/http_status.dart';
// import 'package:network_manager/utils/connectivity/i_connectivity.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:http/http.dart' as http;
// import 'package:mockito/mockito.dart';

// import '../fake_models/fake_stream.dart';
// import 'network_client_test.mocks.dart';

// @GenerateMocks([http.Client])
// @GenerateMocks([IConnectivity])
void main() {
  // global test usages
  // final httpClient = MockClient();
  // final connectivityListener = MockIConnectivity();
  // final blankHeaders = <String, String>{};
  // final env = Environment('DEV', 'example.com', {});

  // final secureStorage = SecureStorageService();
  // final authManager = AuthManager(secureStorage);

  // final controlNotifier = GlobalControlNotifier(ClientInformation(
  //   Environment('local', 'localhost', {}),
  // ));

  // // standardRequest<StandardGetRequest>(..)
  // // --------------------------------------------------------------------------
  // // arrange request
  // final getRequest = StandardRequest(name: 'test');
  // getRequest.requestType = RequestType.GET;
  // getRequest.endpoint = 'api/v1/testEndpoint';
  // test(
  //   'when we call standardRequest with a StandardGetRequest and the application'
  //   ' has no connection to the internet, the result isNotConnected returns '
  //   'true.',
  //   () async {
  //     // arrange
  //     // arrange the connectivity to return false.
  //     when(connectivityListener.connectionChange).thenAnswer((_) => FakeStream());
  //     when(connectivityListener.hasConnection).thenAnswer((_) => false);
  //     final networkClient = NetworkClient(
  //       httpClient,
  //       connectivityListener,
  //       controlNotifier,
  //       authManager,
  //     );

  //     // act
  //     final result = await networkClient.standardRequest(getRequest);

  //     // assert
  //     expect(result.isNotConnected, true);
  //   },
  // );

  // test(
  //   'when we call standardRequest with a StandardGetRequest and the '
  //   'application has connection to the internet and the network'
  //   'returns a not found error'
  //   ' the result isSuccess returns false.',
  //   () async {
  //     // arrange
  //     // arrange network response to return 404
  //     final response = http.Response('body', HttpStatus.notFound);
  //     when(httpClient.get(any, headers: blankHeaders)).thenAnswer((_) => Future(() => response));
  //     // arrange the connectivity to return true.
  //     when(connectivityListener.connectionChange).thenAnswer((_) => FakeStream());
  //     when(connectivityListener.hasConnection).thenAnswer((_) => true);
  //     final networkClient = NetworkClient(
  //       httpClient,
  //       connectivityListener,
  //       controlNotifier,
  //       authManager,
  //     );
  //     // act
  //     final result = await networkClient.standardRequest(getRequest);

  //     // assert
  //     expect(result.isNotConnected, false);
  //     expect(result.isSuccess, false);
  //     expect(result.statusCode, HttpStatus.notFound);
  //   },
  // );

  // test(
  //   'when we call standardRequest with a StandardGetRequest and the '
  //   'application has connection to the internet and the network '
  //   'returns a successful response the result isSuccess returns true.',
  //   () async {
  //     // arrange
  //     // arrange network response to return 404
  //     final response = http.Response('body', HttpStatus.ok);
  //     when(httpClient.get(any, headers: blankHeaders)).thenAnswer((_) => Future(() => response));
  //     // arrange the connectivity to return true.
  //     when(connectivityListener.connectionChange).thenAnswer((_) => FakeStream());
  //     when(connectivityListener.hasConnection).thenAnswer((_) => true);
  //     final networkClient = NetworkClient(
  //       httpClient,
  //       connectivityListener,
  //       controlNotifier,
  //       authManager,
  //     );
  //     // act
  //     final result = await networkClient.standardRequest(getRequest);

  //     // assert
  //     expect(result.isNotConnected, false);
  //     expect(result.isSuccess, true);
  //     expect(result.statusCode, HttpStatus.ok);
  //   },
  // );

  // // standardRequest<StandardPostRequest>(..)
  // // --------------------------------------------------------------------------
  // // arrange request
  // final postRequest = StandardRequest(name: 'test');
  // postRequest.requestType = RequestType.POST;
  // postRequest.endpoint = 'api/v1/testEndpoint';
  // postRequest.jsonBody = '{ "fakeJsonVar" : "fakeJsonValue" }';
  // test(
  //   'when we call standardRequest with a StandardPostRequest and the '
  //   'application has no connection to the internet, the result'
  //   ' isNotConnected returns true.',
  //   () async {
  //     // arrange
  //     // arrange the connectivity to return false.
  //     when(connectivityListener.connectionChange).thenAnswer((_) => FakeStream());
  //     when(connectivityListener.hasConnection).thenAnswer((_) => false);
  //     final networkClient = NetworkClient(
  //       httpClient,
  //       connectivityListener,
  //       controlNotifier,
  //       authManager,
  //     );

  //     // act
  //     final result = await networkClient.standardRequest(postRequest);

  //     // assert
  //     expect(result.isNotConnected, true);
  //   },
  // );

  // test(
  //   'when we call standardRequest with a StandardPostRequest and the'
  //   ' application has connection to the internet and the network'
  //   ' returns a not found error the result isSuccess returns false.',
  //   () async {
  //     // arrange
  //     // arrange network response to return 404
  //     final response = http.Response('body', HttpStatus.notFound);
  //     when(httpClient.post(
  //       any,
  //       headers: blankHeaders,
  //       body: postRequest.jsonBody,
  //     )).thenAnswer((_) => Future(() => response));
  //     // arrange the connectivity to return true.
  //     when(connectivityListener.connectionChange).thenAnswer((_) => FakeStream());
  //     when(connectivityListener.hasConnection).thenAnswer((_) => true);
  //     final networkClient = NetworkClient(
  //       httpClient,
  //       connectivityListener,
  //       controlNotifier,
  //       authManager,
  //     );
  //     // act
  //     final result = await networkClient.standardRequest(postRequest);

  //     // assert
  //     expect(result.isNotConnected, false);
  //     expect(result.isSuccess, false);
  //     expect(result.statusCode, HttpStatus.notFound);
  //   },
  // );

  // test(
  //   'when we call standardRequest with a StandardPostRequest and the'
  //   'application has connection to the internet and the network'
  //   ' returns a successful response the result isSuccess returns true.',
  //   () async {
  //     // arrange
  //     // arrange network response to return 404
  //     final response = http.Response('body', HttpStatus.ok);
  //     when(httpClient.post(
  //       any,
  //       headers: blankHeaders,
  //       body: postRequest.jsonBody,
  //     )).thenAnswer((_) => Future(() => response));
  //     // arrange the connectivity to return true.
  //     when(connectivityListener.connectionChange).thenAnswer((_) => FakeStream());
  //     when(connectivityListener.hasConnection).thenAnswer((_) => true);
  //     final networkClient = NetworkClient(
  //       httpClient,
  //       connectivityListener,
  //       controlNotifier,
  //       authManager,
  //     );
  //     // act
  //     final result = await networkClient.standardRequest(postRequest);

  //     // assert
  //     expect(result.isNotConnected, false);
  //     expect(result.isSuccess, true);
  //     expect(result.statusCode, HttpStatus.ok);
  //   },
  // );

  // // buildHeaders(..)
  // // --------------------------------------------------------------------------
  // test(
  //   'when we call buildHeaders it should collate the headers passed'
  //   'to it and return a full map of both.',
  //   () async {
  //     // arrange
  //     // arrange the connectivity to return true.
  //     when(connectivityListener.connectionChange).thenAnswer((_) => FakeStream());
  //     when(connectivityListener.hasConnection).thenAnswer((_) => true);
  //     final networkClient = NetworkClient(
  //       httpClient,
  //       connectivityListener,
  //       controlNotifier,
  //       authManager,
  //     );
  //     final customRequestHeaders = {'x-test-header': 'test-value'};
  //     // act
  //     final result = networkClient.buildHeaders(customRequestHeaders);

  //     // assert
  //     expect(result, customRequestHeaders);
  //   },
  // );

  // /*

  //  */

  // test(
  //   'when we call graphQLRequest with empty host name it should return exception',
  //   () async {
  //     final networkConfig = Config.fromJson(jsonDecode(dummy_config) as Map<String, dynamic>);

  //     controlNotifier.updateConfig(networkConfig);

  //     // arrange
  //     // arrange the connectivity to return true.
  //     when(connectivityListener.connectionChange).thenAnswer((_) => FakeStream());
  //     when(connectivityListener.hasConnection).thenAnswer((_) => true);

  //     final networkClient = NetworkClient(
  //       httpClient,
  //       connectivityListener,
  //       controlNotifier,
  //       authManager,
  //     );
  //     networkClient.initializeGraphQlClient(config: networkConfig, accessToken: '', headers: blankHeaders);
  //     final graphQLRequest = GraphQLRequest(Model(), '', GraphQlRequestType.query, name: '');
  //     final response = await networkClient.graphQLRequest(graphQLRequest);
  //     expect(response.hasException, true);
  //   },
  // );
}

// final dummy_config = ''' 
// {
//   "environments": [
 
//   ],
//   "restEnvironments": [
 
//   ],
//   "gqlEnvironments": [
//     {
//       "name": "default",
//       "host": ""
//     },
//     {
//       "name": "mock",
//       "comment": "This definition is needed for individual mocks to work",
//       "host": "",
//       "headers": {}
//     }
//   ],
//   "gqlMappingOverrides": {},
//   "headers": {
//     "x-channel": "x-channel",
//     "Ocp-Apim-Subscription-Key": "7ba0d57f0bb247639c0fdc49fbdcc393"
//   },
//   "useMockNetworkClient": true,
//   "certificateType": "dev_qa"
// }
// ''';

// class Model extends BaseDataModel {
//   @override
//   void fromJsonToModel(Map<String, dynamic> value) {}
// }
