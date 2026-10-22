import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';

class SmsService {
  String _getPassword(Session session, String key) {
    // 1. Try session.serverpod.getPassword(key)
    String? val = session.serverpod.getPassword(key);
    if (val != null && val.isNotEmpty) return val;

    // 2. Try session.passwords[key]
    val = session.passwords[key];
    if (val != null && val.isNotEmpty) return val;

    // 3. Fallback: read directly from passwords.yaml on disk so it works even before a server restart
    try {
      final candidates = [
        'config/passwords.yaml',
        'meer_server/config/passwords.yaml',
        '../meer_server/config/passwords.yaml',
      ];
      for (var path in candidates) {
        final file = File(path);
        if (file.existsSync()) {
          for (var line in file.readAsLinesSync()) {
            final trimmed = line.trim();
            if (trimmed.startsWith('$key:')) {
              var raw = trimmed.substring('$key:'.length).trim();
              if ((raw.startsWith('"') && raw.endsWith('"')) ||
                  (raw.startsWith("'") && raw.endsWith("'"))) {
                raw = raw.substring(1, raw.length - 1);
              }
              if (raw.isNotEmpty) return raw;
            }
          }
        }
      }
    } catch (_) {}

    return '';
  }

  // توحيد صيغة الرقم لتصبح بالصيغة الدولية 9665xxxxxxxx
  String formatPhone(String phone) {
    String cleaned = phone.replaceAll(RegExp(r'[\s\-\(\)]'), '').trim();
    cleaned = cleaned.replaceAll(RegExp(r'^(?:\+?966|00966|0)+'), '');
    return '966$cleaned';
  }

  // دالة إرسال الـ OTP
  Future<bool> sendOtp(Session session, String phone) async {
    String formattedPhone = formatPhone(phone);
    String apiPhone = '+$formattedPhone';

    // جلب الإعدادات من باسوردات السيرفر أو من الملف مباشرة
    String apiKey = _getPassword(session, 'authenticaApiKey');
    String url = _getPassword(session, 'authenticaUrl');
    if (url.trim().isEmpty) {
      url = 'https://api.authentica.sa/api/v2/send-otp';
    }
    String templateId = _getPassword(session, 'authenticaTemplateId');
    if (templateId.trim().isEmpty) {
      templateId = '5';
    }
    final dynamic templateIdValue = int.tryParse(templateId) ?? templateId;

    if (apiKey.trim().isEmpty) {
      session.log(
        'SMS Error: authenticaApiKey is not configured in passwords.yaml under shared:',
        level: LogLevel.error,
      );
      return false;
    }

    try {
      session.log(
        'Sending OTP to $apiPhone via $url',
        level: LogLevel.info,
      );

      var response = await http.post(
        Uri.parse(url),
        headers: {
          'X-Authorization': apiKey,
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'phone': apiPhone,
          'method': 'sms',
          'template_id': templateIdValue,
        }),
      );

      session.log(
        'Authentica Send OTP response [${response.statusCode}]: ${response.body}',
        level: response.statusCode == 200 ? LogLevel.info : LogLevel.warning,
      );

      if (response.statusCode == 200) {
        try {
          var data = jsonDecode(response.body);
          if (data is Map) {
            if (data.containsKey('status') && data['status'] == false) {
              return false;
            }
            if (data.containsKey('success') && data['success'] == false) {
              return false;
            }
          }
        } catch (_) {}
        return true;
      }

      return false;
    } catch (e) {
      session.log('SMS Exception: $e', level: LogLevel.error);
      return false;
    }
  }

  // دالة التحقق من الـ OTP
  Future<bool> verifyOtp(Session session, String phone, String otp) async {
    String formattedPhone = formatPhone(phone);
    String apiPhone = '+$formattedPhone';

    String apiKey = _getPassword(session, 'authenticaApiKey');
    String url = _getPassword(session, 'authenticaVerifyUrl');
    if (url.trim().isEmpty) {
      url = 'https://api.authentica.sa/api/v2/verify-otp';
    }

    if (apiKey.trim().isEmpty) {
      session.log(
        'SMS Error: authenticaApiKey is not configured in passwords.yaml under shared:',
        level: LogLevel.error,
      );
      return false;
    }

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'X-Authorization': apiKey,
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'phone': apiPhone,
          'otp': otp,
        }),
      );

      session.log(
        'Authentica Verify OTP response [${response.statusCode}]: ${response.body}',
        level: response.statusCode == 200 ? LogLevel.info : LogLevel.warning,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data is Map) {
          return data['verified'] == true ||
              data['status'] == true ||
              data['success'] == true ||
              data['status'] == 'success';
        }

        return false;
      }

      return false;
    } catch (e) {
      session.log('SMS Verify Exception: $e', level: LogLevel.error);
      return false;
    }
  }
}
