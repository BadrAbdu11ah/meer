/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:meer_server/src/generated/model/order_info.dart' as _i8hwzj5x;
import 'package:meer_server/src/generated/model/order_item.dart' as _ixsojegs;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i1n3uhu0;
import '../auth/google_idp_endpoint.dart' as _i71axiz0;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../endpoints/app_auth_endpoint.dart' as _ifrhcmrx;
import '../endpoints/order_endpoint.dart' as _itwfdqvf;
import '../greetings/greeting_endpoint.dart' as _il624ik7;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'googleIdp': _i71axiz0.GoogleIdpEndpoint()
        ..initialize(
          server,
          'googleIdp',
          null,
        ),
      'jwtRefresh': _inwq3ztq.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'appAuth': _ifrhcmrx.AppAuthEndpoint()
        ..initialize(
          server,
          'appAuth',
          null,
        ),
      'order': _itwfdqvf.OrderEndpoint()
        ..initialize(
          server,
          'order',
          null,
        ),
      'greeting': _il624ik7.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
    };
    connectors['googleIdp'] = _is.EndpointConnector(
      name: 'googleIdp',
      endpoint: endpoints['googleIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'idToken': _is.ParameterDescription(
              name: 'idToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'accessToken': _is.ParameterDescription(
              name: 'accessToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['googleIdp'] as _i71axiz0.GoogleIdpEndpoint).login(
                    session,
                    idToken: params['idToken'],
                    accessToken: params['accessToken'],
                  ),
        ),
        'loginWithCode': _is.MethodConnector(
          name: 'loginWithCode',
          params: {
            'code': _is.ParameterDescription(
              name: 'code',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'codeVerifier': _is.ParameterDescription(
              name: 'codeVerifier',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'redirectUri': _is.ParameterDescription(
              name: 'redirectUri',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['googleIdp'] as _i71axiz0.GoogleIdpEndpoint)
                  .loginWithCode(
                    session,
                    code: params['code'],
                    codeVerifier: params['codeVerifier'],
                    redirectUri: params['redirectUri'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['googleIdp'] as _i71axiz0.GoogleIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _inwq3ztq.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['appAuth'] = _is.EndpointConnector(
      name: 'appAuth',
      endpoint: endpoints['appAuth']!,
      methodConnectors: {
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['appAuth'] as _ifrhcmrx.AppAuthEndpoint)
                  .hasAccount(session),
        ),
        'sendOtp': _is.MethodConnector(
          name: 'sendOtp',
          params: {
            'phone': _is.ParameterDescription(
              name: 'phone',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['appAuth'] as _ifrhcmrx.AppAuthEndpoint).sendOtp(
                    session,
                    params['phone'],
                  ),
        ),
        'verifyOtp': _is.MethodConnector(
          name: 'verifyOtp',
          params: {
            'phone': _is.ParameterDescription(
              name: 'phone',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'code': _is.ParameterDescription(
              name: 'code',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['appAuth'] as _ifrhcmrx.AppAuthEndpoint).verifyOtp(
                    session,
                    params['phone'],
                    params['code'],
                  ),
        ),
        'syncCurrentUser': _is.MethodConnector(
          name: 'syncCurrentUser',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['appAuth'] as _ifrhcmrx.AppAuthEndpoint)
                  .syncCurrentUser(session),
        ),
        'syncGoogleUser': _is.MethodConnector(
          name: 'syncGoogleUser',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['appAuth'] as _ifrhcmrx.AppAuthEndpoint)
                  .syncGoogleUser(session),
        ),
      },
    );
    connectors['order'] = _is.EndpointConnector(
      name: 'order',
      endpoint: endpoints['order']!,
      methodConnectors: {
        'createOrder': _is.MethodConnector(
          name: 'createOrder',
          params: {
            'order': _is.ParameterDescription(
              name: 'order',
              type: _is.getType<_i8hwzj5x.OrderInfo>(),
              nullable: false,
            ),
            'items': _is.ParameterDescription(
              name: 'items',
              type: _is.getType<List<_ixsojegs.OrderItem>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['order'] as _itwfdqvf.OrderEndpoint).createOrder(
                    session,
                    params['order'],
                    params['items'],
                  ),
        ),
        'getCustomerOrders': _is.MethodConnector(
          name: 'getCustomerOrders',
          params: {
            'customerId': _is.ParameterDescription(
              name: 'customerId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['order'] as _itwfdqvf.OrderEndpoint)
                  .getCustomerOrders(
                    session,
                    params['customerId'],
                  ),
        ),
        'getSellerOrders': _is.MethodConnector(
          name: 'getSellerOrders',
          params: {
            'sellerId': _is.ParameterDescription(
              name: 'sellerId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['order'] as _itwfdqvf.OrderEndpoint)
                  .getSellerOrders(
                    session,
                    params['sellerId'],
                  ),
        ),
        'getAvailableOrdersForDrivers': _is.MethodConnector(
          name: 'getAvailableOrdersForDrivers',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['order'] as _itwfdqvf.OrderEndpoint)
                  .getAvailableOrdersForDrivers(session),
        ),
        'acceptOrderAsDriver': _is.MethodConnector(
          name: 'acceptOrderAsDriver',
          params: {
            'orderId': _is.ParameterDescription(
              name: 'orderId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'driverId': _is.ParameterDescription(
              name: 'driverId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['order'] as _itwfdqvf.OrderEndpoint)
                  .acceptOrderAsDriver(
                    session,
                    params['orderId'],
                    params['driverId'],
                  ),
        ),
        'updateOrderStatus': _is.MethodConnector(
          name: 'updateOrderStatus',
          params: {
            'orderId': _is.ParameterDescription(
              name: 'orderId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'newStatus': _is.ParameterDescription(
              name: 'newStatus',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['order'] as _itwfdqvf.OrderEndpoint)
                  .updateOrderStatus(
                    session,
                    params['orderId'],
                    params['newStatus'],
                  ),
        ),
        'getOrderWithDetails': _is.MethodConnector(
          name: 'getOrderWithDetails',
          params: {
            'orderId': _is.ParameterDescription(
              name: 'orderId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['order'] as _itwfdqvf.OrderEndpoint)
                  .getOrderWithDetails(
                    session,
                    params['orderId'],
                  ),
        ),
      },
    );
    connectors['greeting'] = _is.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _is.MethodConnector(
          name: 'hello',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['greeting'] as _il624ik7.GreetingEndpoint).hello(
                    session,
                    params['name'],
                  ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth'] = _i1n3uhu0.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }
}
