import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';

typedef SmsPasswordResolver =
    String? Function(
      Session session,
      String key,
    );

class SmsService {
  SmsService({
    this._httpClient,
    this._passwordResolver,
    this.requestTimeout = const Duration(seconds: 15),
  });

  final http.Client? _httpClient;
  final SmsPasswordResolver? _passwordResolver;

  final Duration requestTimeout;

  static const _defaultSendUrl = 'https://api.authentica.sa/api/v2/send-otp';

  static const _defaultVerifyUrl =
      'https://api.authentica.sa/api/v2/verify-otp';

  // قراءة إعدادات المصادقة من Serverpod.
  String _getPassword(Session session, String key) {
    final injectedValue = _passwordResolver?.call(session, key);

    if (injectedValue != null && injectedValue.isNotEmpty) {
      return injectedValue;
    }

    final serverPassword = session.serverpod.getPassword(key);

    if (serverPassword != null && serverPassword.isNotEmpty) {
      return serverPassword;
    }

    final sessionPassword = session.passwords[key];

    if (sessionPassword != null && sessionPassword.isNotEmpty) {
      return sessionPassword;
    }

    return '';
  }

  // توحيد صيغة رقم الهاتف السعودي.
  String formatPhone(String phone) {
    var cleaned = phone.replaceAll(RegExp(r'[\s\-\(\)]'), '').trim();

    cleaned = cleaned.replaceAll(
      RegExp(r'^(?:\+?966|00966|0)+'),
      '',
    );

    return '966$cleaned';
  }

  // إرسال HTTP من خلال Client قابل للاستبدال في الاختبارات.
  Future<http.Response> _post(
    Uri uri, {
    required Map<String, String> headers,
    required String body,
  }) {
    final client = _httpClient;

    if (client != null) {
      return client.post(
        uri,
        headers: headers,
        body: body,
      );
    }

    return http.post(
      uri,
      headers: headers,
      body: body,
    );
  }

  // التحقق من صلاحية عنوان Authentica.
  Uri? _parseSecureUrl(String value) {
    final uri = Uri.tryParse(value);

    if (uri == null ||
        uri.scheme != 'https' ||
        uri.host.isEmpty ||
        uri.userInfo.isNotEmpty) {
      return null;
    }

    return uri;
  }

  Map<String, String> _headers(String apiKey) {
    return {
      'X-Authorization': apiKey,
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }

  // إرسال OTP.
  Future<bool> sendOtp(Session session, String phone) async {
    final formattedPhone = formatPhone(phone);
    final apiPhone = '+$formattedPhone';

    final apiKey = _getPassword(
      session,
      'authenticaApiKey',
    ).trim();

    final configuredUrl = _getPassword(
      session,
      'authenticaUrl',
    ).trim();

    final url = configuredUrl.isEmpty ? _defaultSendUrl : configuredUrl;

    final templateId = _getPassword(
      session,
      'authenticaTemplateId',
    ).trim();

    final templateIdValue = templateId.isEmpty ? 5 : int.tryParse(templateId);

    if (apiKey.isEmpty) {
      session.log(
        'Authentica API key is not configured.',
        level: LogLevel.error,
      );
      return false;
    }

    if (templateIdValue == null || templateIdValue <= 0) {
      session.log(
        'Authentica template ID configuration is invalid.',
        level: LogLevel.error,
      );
      return false;
    }

    final uri = _parseSecureUrl(url);

    if (uri == null) {
      session.log(
        'Authentica send URL configuration is invalid.',
        level: LogLevel.error,
      );
      return false;
    }

    try {
      final response = await _post(
        uri,
        headers: _headers(apiKey),
        body: jsonEncode({
          'phone': apiPhone,
          'method': 'sms',
          'template_id': templateIdValue,
        }),
      ).timeout(requestTimeout);

      if (response.statusCode != 200) {
        session.log(
          'Authentica OTP send failed. '
          'HTTP status: ${response.statusCode}.',
          level: LogLevel.warning,
        );
        return false;
      }

      final data = jsonDecode(response.body);

      if (data is! Map || data['success'] != true) {
        session.log(
          'Authentica did not confirm OTP sending.',
          level: LogLevel.warning,
        );
        return false;
      }

      return true;
    } on TimeoutException {
      session.log(
        'Authentica OTP send request timed out.',
        level: LogLevel.warning,
      );
      return false;
    } catch (e) {
      session.log(
        'Authentica OTP send failed: ${e.runtimeType}.',
        level: LogLevel.error,
      );
      return false;
    }
  }

  // التحقق من OTP.
  Future<bool> verifyOtp(
    Session session,
    String phone,
    String otp,
  ) async {
    final formattedPhone = formatPhone(phone);
    final apiPhone = '+$formattedPhone';

    if (otp.trim().isEmpty) {
      return false;
    }

    final apiKey = _getPassword(
      session,
      'authenticaApiKey',
    ).trim();

    final configuredUrl = _getPassword(
      session,
      'authenticaVerifyUrl',
    ).trim();

    final url = configuredUrl.isEmpty ? _defaultVerifyUrl : configuredUrl;

    if (apiKey.isEmpty) {
      session.log(
        'Authentica API key is not configured.',
        level: LogLevel.error,
      );
      return false;
    }

    final uri = _parseSecureUrl(url);

    if (uri == null) {
      session.log(
        'Authentica verification URL configuration is invalid.',
        level: LogLevel.error,
      );
      return false;
    }

    try {
      final response = await _post(
        uri,
        headers: _headers(apiKey),
        body: jsonEncode({
          'phone': apiPhone,
          'otp': otp.trim(),
        }),
      ).timeout(requestTimeout);

      if (response.statusCode != 200) {
        session.log(
          'Authentica OTP verification failed. '
          'HTTP status: ${response.statusCode}.',
          level: LogLevel.warning,
        );
        return false;
      }

      final data = jsonDecode(response.body);

      if (data is! Map) {
        session.log(
          'Authentica OTP verification returned an unexpected response type.',
          level: LogLevel.warning,
        );
        return false;
      }

      final status = data['status'];

      if (status is! bool) {
        session.log(
          'Authentica OTP verification returned an invalid status field. '
          'statusType=${status.runtimeType}.',
          level: LogLevel.warning,
        );
        return false;
      }

      return status;
    } on TimeoutException {
      session.log(
        'Authentica OTP verification request timed out.',
        level: LogLevel.warning,
      );
      return false;
    } catch (e) {
      session.log(
        'Authentica OTP verification failed: ${e.runtimeType}.',
        level: LogLevel.error,
      );
      return false;
    }
  }
}
