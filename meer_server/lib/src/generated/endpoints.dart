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
import 'package:meer_server/src/generated/model/meer_city.dart' as _ibpct1hm;
import 'package:meer_server/src/generated/model/order_item_request.dart'
    as _i4g4bzck;
import 'package:meer_server/src/generated/model/product.dart' as _iq8dxf2n;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i1n3uhu0;
import '../auth/google_idp_endpoint.dart' as _i71axiz0;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../endpoints/app_auth_endpoint.dart' as _ifrhcmrx;
import '../endpoints/cart_endpoint.dart' as _i4pgg4av;
import '../endpoints/favorite_endpoint.dart' as _i5chwg2z;
import '../endpoints/image_endpoint.dart' as _iu0td00j;
import '../endpoints/order_endpoint.dart' as _itwfdqvf;
import '../endpoints/product_endpoint.dart' as _im5j1753;
import '../endpoints/seller_endpoint.dart' as _ifhnucmp;
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
      'cart': _i4pgg4av.CartEndpoint()
        ..initialize(
          server,
          'cart',
          null,
        ),
      'favorite': _i5chwg2z.FavoriteEndpoint()
        ..initialize(
          server,
          'favorite',
          null,
        ),
      'image': _iu0td00j.ImageEndpoint()
        ..initialize(
          server,
          'image',
          null,
        ),
      'order': _itwfdqvf.OrderEndpoint()
        ..initialize(
          server,
          'order',
          null,
        ),
      'product': _im5j1753.ProductEndpoint()
        ..initialize(
          server,
          'product',
          null,
        ),
      'seller': _ifhnucmp.SellerEndpoint()
        ..initialize(
          server,
          'seller',
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
    connectors['cart'] = _is.EndpointConnector(
      name: 'cart',
      endpoint: endpoints['cart']!,
      methodConnectors: {
        'getMyCart': _is.MethodConnector(
          name: 'getMyCart',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['cart'] as _i4pgg4av.CartEndpoint)
                  .getMyCart(session),
        ),
        'addItem': _is.MethodConnector(
          name: 'addItem',
          params: {
            'productId': _is.ParameterDescription(
              name: 'productId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'quantity': _is.ParameterDescription(
              name: 'quantity',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['cart'] as _i4pgg4av.CartEndpoint).addItem(
                session,
                params['productId'],
                params['quantity'],
              ),
        ),
        'updateQuantity': _is.MethodConnector(
          name: 'updateQuantity',
          params: {
            'productId': _is.ParameterDescription(
              name: 'productId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'quantity': _is.ParameterDescription(
              name: 'quantity',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['cart'] as _i4pgg4av.CartEndpoint).updateQuantity(
                    session,
                    params['productId'],
                    params['quantity'],
                  ),
        ),
        'removeItem': _is.MethodConnector(
          name: 'removeItem',
          params: {
            'productId': _is.ParameterDescription(
              name: 'productId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['cart'] as _i4pgg4av.CartEndpoint).removeItem(
                    session,
                    params['productId'],
                  ),
        ),
        'clearCart': _is.MethodConnector(
          name: 'clearCart',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['cart'] as _i4pgg4av.CartEndpoint)
                  .clearCart(session),
        ),
      },
    );
    connectors['favorite'] = _is.EndpointConnector(
      name: 'favorite',
      endpoint: endpoints['favorite']!,
      methodConnectors: {
        'getMyFavorites': _is.MethodConnector(
          name: 'getMyFavorites',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['favorite'] as _i5chwg2z.FavoriteEndpoint)
                  .getMyFavorites(session),
        ),
        'addFavorite': _is.MethodConnector(
          name: 'addFavorite',
          params: {
            'productId': _is.ParameterDescription(
              name: 'productId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['favorite'] as _i5chwg2z.FavoriteEndpoint)
                  .addFavorite(
                    session,
                    params['productId'],
                  ),
        ),
        'removeFavorite': _is.MethodConnector(
          name: 'removeFavorite',
          params: {
            'productId': _is.ParameterDescription(
              name: 'productId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['favorite'] as _i5chwg2z.FavoriteEndpoint)
                  .removeFavorite(
                    session,
                    params['productId'],
                  ),
        ),
        'clearMyFavorites': _is.MethodConnector(
          name: 'clearMyFavorites',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['favorite'] as _i5chwg2z.FavoriteEndpoint)
                  .clearMyFavorites(session),
        ),
      },
    );
    connectors['image'] = _is.EndpointConnector(
      name: 'image',
      endpoint: endpoints['image']!,
      methodConnectors: {
        'createProductImageUpload': _is.MethodConnector(
          name: 'createProductImageUpload',
          params: {
            'fileExtension': _is.ParameterDescription(
              name: 'fileExtension',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['image'] as _iu0td00j.ImageEndpoint)
                  .createProductImageUpload(
                    session,
                    params['fileExtension'],
                  ),
        ),
        'verifyProductImageUpload': _is.MethodConnector(
          name: 'verifyProductImageUpload',
          params: {
            'filePath': _is.ParameterDescription(
              name: 'filePath',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['image'] as _iu0td00j.ImageEndpoint)
                  .verifyProductImageUpload(
                    session,
                    params['filePath'],
                  ),
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
            'requestedItems': _is.ParameterDescription(
              name: 'requestedItems',
              type: _is.getType<List<_i4g4bzck.OrderItemRequest>>(),
              nullable: false,
            ),
            'deliveryAddress': _is.ParameterDescription(
              name: 'deliveryAddress',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'deliveryLatitude': _is.ParameterDescription(
              name: 'deliveryLatitude',
              type: _is.getType<double?>(),
              nullable: true,
            ),
            'deliveryLongitude': _is.ParameterDescription(
              name: 'deliveryLongitude',
              type: _is.getType<double?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['order'] as _itwfdqvf.OrderEndpoint).createOrder(
                    session,
                    params['requestedItems'],
                    params['deliveryAddress'],
                    params['deliveryLatitude'],
                    params['deliveryLongitude'],
                  ),
        ),
        'getMyCustomerOrders': _is.MethodConnector(
          name: 'getMyCustomerOrders',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['order'] as _itwfdqvf.OrderEndpoint)
                  .getMyCustomerOrders(session),
        ),
        'cancelMyOrder': _is.MethodConnector(
          name: 'cancelMyOrder',
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
              ) async =>
                  (endpoints['order'] as _itwfdqvf.OrderEndpoint).cancelMyOrder(
                    session,
                    params['orderId'],
                  ),
        ),
        'getMySellerOrders': _is.MethodConnector(
          name: 'getMySellerOrders',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['order'] as _itwfdqvf.OrderEndpoint)
                  .getMySellerOrders(session),
        ),
        'acceptMyOrder': _is.MethodConnector(
          name: 'acceptMyOrder',
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
              ) async =>
                  (endpoints['order'] as _itwfdqvf.OrderEndpoint).acceptMyOrder(
                    session,
                    params['orderId'],
                  ),
        ),
        'rejectMyOrder': _is.MethodConnector(
          name: 'rejectMyOrder',
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
              ) async =>
                  (endpoints['order'] as _itwfdqvf.OrderEndpoint).rejectMyOrder(
                    session,
                    params['orderId'],
                  ),
        ),
        'markMyOrderReady': _is.MethodConnector(
          name: 'markMyOrderReady',
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
                  .markMyOrderReady(
                    session,
                    params['orderId'],
                  ),
        ),
        'markMyOrderCompleted': _is.MethodConnector(
          name: 'markMyOrderCompleted',
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
                  .markMyOrderCompleted(
                    session,
                    params['orderId'],
                  ),
        ),
      },
    );
    connectors['product'] = _is.EndpointConnector(
      name: 'product',
      endpoint: endpoints['product']!,
      methodConnectors: {
        'addProduct': _is.MethodConnector(
          name: 'addProduct',
          params: {
            'product': _is.ParameterDescription(
              name: 'product',
              type: _is.getType<_iq8dxf2n.Product>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['product'] as _im5j1753.ProductEndpoint)
                  .addProduct(
                    session,
                    params['product'],
                  ),
        ),
        'getAllAvailableProducts': _is.MethodConnector(
          name: 'getAllAvailableProducts',
          params: {
            'city': _is.ParameterDescription(
              name: 'city',
              type: _is.getType<_ibpct1hm.MeerCity>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['product'] as _im5j1753.ProductEndpoint)
                  .getAllAvailableProducts(
                    session,
                    params['city'],
                  ),
        ),
        'getProductsBySeller': _is.MethodConnector(
          name: 'getProductsBySeller',
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
              ) async => (endpoints['product'] as _im5j1753.ProductEndpoint)
                  .getProductsBySeller(
                    session,
                    params['sellerId'],
                  ),
        ),
        'getMyProducts': _is.MethodConnector(
          name: 'getMyProducts',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['product'] as _im5j1753.ProductEndpoint)
                  .getMyProducts(session),
        ),
        'toggleProductAvailability': _is.MethodConnector(
          name: 'toggleProductAvailability',
          params: {
            'productId': _is.ParameterDescription(
              name: 'productId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'isAvailable': _is.ParameterDescription(
              name: 'isAvailable',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['product'] as _im5j1753.ProductEndpoint)
                  .toggleProductAvailability(
                    session,
                    params['productId'],
                    params['isAvailable'],
                  ),
        ),
        'searchProducts': _is.MethodConnector(
          name: 'searchProducts',
          params: {
            'search': _is.ParameterDescription(
              name: 'search',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'city': _is.ParameterDescription(
              name: 'city',
              type: _is.getType<_ibpct1hm.MeerCity>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['product'] as _im5j1753.ProductEndpoint)
                  .searchProducts(
                    session,
                    params['search'],
                    params['city'],
                  ),
        ),
        'updateProduct': _is.MethodConnector(
          name: 'updateProduct',
          params: {
            'input': _is.ParameterDescription(
              name: 'input',
              type: _is.getType<_iq8dxf2n.Product>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['product'] as _im5j1753.ProductEndpoint)
                  .updateProduct(
                    session,
                    params['input'],
                  ),
        ),
        'deleteProduct': _is.MethodConnector(
          name: 'deleteProduct',
          params: {
            'productId': _is.ParameterDescription(
              name: 'productId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['product'] as _im5j1753.ProductEndpoint)
                  .deleteProduct(
                    session,
                    params['productId'],
                  ),
        ),
      },
    );
    connectors['seller'] = _is.EndpointConnector(
      name: 'seller',
      endpoint: endpoints['seller']!,
      methodConnectors: {
        'getPublicSellerInfo': _is.MethodConnector(
          name: 'getPublicSellerInfo',
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
              ) async => (endpoints['seller'] as _ifhnucmp.SellerEndpoint)
                  .getPublicSellerInfo(
                    session,
                    params['sellerId'],
                  ),
        ),
        'activateSeller': _is.MethodConnector(
          name: 'activateSeller',
          params: {
            'storeName': _is.ParameterDescription(
              name: 'storeName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'storeDescription': _is.ParameterDescription(
              name: 'storeDescription',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'storeAddress': _is.ParameterDescription(
              name: 'storeAddress',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'storeCity': _is.ParameterDescription(
              name: 'storeCity',
              type: _is.getType<_ibpct1hm.MeerCity>(),
              nullable: false,
            ),
            'storeDistrict': _is.ParameterDescription(
              name: 'storeDistrict',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'latitude': _is.ParameterDescription(
              name: 'latitude',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'longitude': _is.ParameterDescription(
              name: 'longitude',
              type: _is.getType<double>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['seller'] as _ifhnucmp.SellerEndpoint)
                  .activateSeller(
                    session,
                    params['storeName'],
                    params['storeDescription'],
                    params['storeAddress'],
                    params['storeCity'],
                    params['storeDistrict'],
                    params['latitude'],
                    params['longitude'],
                  ),
        ),
        'getMyProfile': _is.MethodConnector(
          name: 'getMyProfile',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['seller'] as _ifhnucmp.SellerEndpoint)
                  .getMyProfile(session),
        ),
        'updateMyDeliveryLocation': _is.MethodConnector(
          name: 'updateMyDeliveryLocation',
          params: {
            'address': _is.ParameterDescription(
              name: 'address',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'latitude': _is.ParameterDescription(
              name: 'latitude',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'longitude': _is.ParameterDescription(
              name: 'longitude',
              type: _is.getType<double>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['seller'] as _ifhnucmp.SellerEndpoint)
                  .updateMyDeliveryLocation(
                    session,
                    params['address'],
                    params['latitude'],
                    params['longitude'],
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
