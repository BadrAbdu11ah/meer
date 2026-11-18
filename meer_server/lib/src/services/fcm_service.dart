import 'dart:convert';
import 'dart:io';

import 'package:googleapis_auth/auth_io.dart';

class FcmService {
  static const String _projectId = 'meer-b9762';

  static const String _messagingScope =
      'https://www.googleapis.com/auth/firebase.messaging';

  AutoRefreshingAuthClient? _authClient;
  Future<void>? _initializing;
  bool _disposed = false;

  /// تهيئة عميل Google OAuth باستخدام Service Account.
  Future<void> initialize() async {
    if (_disposed) {
      throw StateError('FcmService has been disposed.');
    }

    if (_authClient != null) return;

    final existingInitialization = _initializing;

    if (existingInitialization != null) {
      await existingInitialization;
      return;
    }

    final initialization = _initialize();
    _initializing = initialization;

    try {
      await initialization;
    } finally {
      if (identical(_initializing, initialization)) {
        _initializing = null;
      }
    }
  }

  Future<void> _initialize() async {
    final credentialsPath =
        Platform.environment['GOOGLE_APPLICATION_CREDENTIALS'];

    if (credentialsPath == null || credentialsPath.trim().isEmpty) {
      throw StateError(
        'GOOGLE_APPLICATION_CREDENTIALS is not configured.',
      );
    }

    final credentialsFile = File(credentialsPath);

    if (!await credentialsFile.exists()) {
      throw StateError(
        'Firebase Service Account file was not found.',
      );
    }

    final credentialsContent = await credentialsFile.readAsString();
    final decodedCredentials = jsonDecode(credentialsContent);

    if (decodedCredentials is! Map) {
      throw FormatException('Invalid Service Account JSON.');
    }

    final credentialsJson = Map<String, dynamic>.from(
      decodedCredentials,
    );

    final credentialsProjectId = credentialsJson['project_id']?.toString();

    if (credentialsProjectId != _projectId) {
      throw StateError(
        'Service Account project does not match the Meer Firebase project.',
      );
    }

    final credentials = ServiceAccountCredentials.fromJson(
      credentialsJson,
    );

    _authClient = await clientViaServiceAccount(
      credentials,
      const [_messagingScope],
    );
  }

  /// إرسال إشعار إلى Firebase Installation ID محدد.
  ///
  /// يرجع اسم الرسالة الذي يصدره Firebase عند نجاح الإرسال.
  Future<String> sendToInstallation({
    required String installationId,
    required String title,
    required String body,
    Map<String, String> data = const {},
  }) async {
    final normalizedId = installationId.trim();

    if (normalizedId.isEmpty) {
      throw ArgumentError('Installation ID cannot be empty.');
    }

    if (title.trim().isEmpty) {
      throw ArgumentError('Notification title cannot be empty.');
    }

    await initialize();

    final url = Uri.https(
      'fcm.googleapis.com',
      '/v1/projects/$_projectId/messages:send',
    );

    final message = <String, dynamic>{
      'fid': normalizedId,
      'notification': {
        'title': title,
        'body': body,
      },
      'android': {
        'priority': 'HIGH',
        'notification': {
          'channel_id': 'meer_orders_channel',
        },
      },
      if (data.isNotEmpty) 'data': data,
    };

    final response = await _authClient!.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'message': message,
      }),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw FcmSendException.fromResponse(
        response.statusCode,
        response.body,
      );
    }

    final responseData = jsonDecode(response.body);

    if (responseData is Map) {
      return responseData['name']?.toString() ?? '';
    }

    return '';
  }

  void dispose() {
    if (_disposed) return;

    _disposed = true;
    _authClient?.close();
    _authClient = null;
  }
}

class FcmSendException implements Exception {
  const FcmSendException({
    required this.statusCode,
    required this.status,
    required this.message,
  });

  final int statusCode;
  final String status;
  final String message;

  factory FcmSendException.fromResponse(
    int statusCode,
    String responseBody,
  ) {
    var status = 'UNKNOWN';
    var message = 'Firebase rejected the notification request.';

    try {
      final decoded = jsonDecode(responseBody);

      if (decoded is Map && decoded['error'] is Map) {
        final error = Map<String, dynamic>.from(
          decoded['error'] as Map,
        );

        status = error['status']?.toString() ?? status;
        message = error['message']?.toString() ?? message;
      }
    } on FormatException {
      // نستخدم الرسالة الافتراضية إذا لم يكن الرد JSON صالحًا.
    }

    return FcmSendException(
      statusCode: statusCode,
      status: status,
      message: message,
    );
  }

  bool get isUnregistered => status == 'UNREGISTERED' || status == 'NOT_FOUND';

  @override
  String toString() {
    return 'FcmSendException('
        'HTTP $statusCode, $status): $message';
  }
}
