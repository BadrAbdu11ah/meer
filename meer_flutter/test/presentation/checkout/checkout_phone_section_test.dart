import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meer_flutter/presentation/checkout/view/widgets/checkout_phone_section.dart';

const _sendLabel = 'إرسال رمز التحقق';
const _resendLabel = 'إعادة إرسال رمز التحقق';
const _sendingLabel = 'جارٍ إرسال الرمز...';

String _cooldownLabel(int seconds) => 'إعادة الإرسال بعد $seconds ث';

/// الحالة التي يمررها الـ BLoC للقسم، قابلة للتغيير من الاختبار.
class _Harness {
  DateTime? codeSentAt;
  bool isPhoneCodeSent = false;
  bool isSendingPhoneCode = false;
  bool isVerifyingPhone = false;
  bool isSubmitting = false;
  bool isPhoneVerified = false;
  bool showSection = true;
  Key sectionKey = const ValueKey('section');
  int sendPresses = 0;

  final phoneController = TextEditingController(text: '0501234567');
  final codeController = TextEditingController();

  late StateSetter _setState;

  /// يحاكي نجاح الإرسال: الـ BLoC يسجل وقت الإرسال الحالي.
  void sendSucceeded(WidgetTester tester) {
    update(() {
      isSendingPhoneCode = false;
      isPhoneCodeSent = true;
      codeSentAt = tester.binding.clock.now().toUtc();
    });
  }

  void update(VoidCallback change) => _setState(change);

  Widget build(WidgetTester tester) {
    return MaterialApp(
      home: Scaffold(
        body: StatefulBuilder(
          builder: (context, setState) {
            _setState = setState;

            if (!showSection) return const SizedBox.shrink();

            return CheckoutPhoneSection(
              key: sectionKey,
              phoneController: phoneController,
              codeController: codeController,
              isPhoneVerified: isPhoneVerified,
              isSendingPhoneCode: isSendingPhoneCode,
              isPhoneCodeSent: isPhoneCodeSent,
              codeSentAt: codeSentAt,
              isVerifyingPhone: isVerifyingPhone,
              isSubmitting: isSubmitting,
              onSendPhoneCode: () => sendPresses++,
              onVerifyPhone: () {},
              // ساعة الاختبار الوهمية: تتقدم مع tester.pump فقط.
              now: () => tester.binding.clock.now(),
            );
          },
        ),
      ),
    );
  }
}

OutlinedButton _sendButton(WidgetTester tester) =>
    tester.widget<OutlinedButton>(find.bySubtype<OutlinedButton>());

bool _isEnabled(WidgetTester tester) => _sendButton(tester).onPressed != null;

void main() {
  const oneSecond = Duration(seconds: 1);

  testWidgets(
    'when no code was sent then the send button is enabled without a '
    'countdown',
    (tester) async {
      final harness = _Harness();
      await tester.pumpWidget(harness.build(tester));

      expect(find.text(_sendLabel), findsOneWidget);
      expect(_isEnabled(tester), isTrue);

      await tester.tap(find.text(_sendLabel));
      expect(harness.sendPresses, 1);
    },
  );

  testWidgets(
    'when the first send succeeds then the countdown starts at 60 and '
    'ticks every second',
    (tester) async {
      final harness = _Harness();
      await tester.pumpWidget(harness.build(tester));

      harness.sendSucceeded(tester);
      await tester.pump();

      expect(find.text(_cooldownLabel(60)), findsOneWidget);
      expect(_isEnabled(tester), isFalse);

      await tester.pump(oneSecond);
      expect(find.text(_cooldownLabel(59)), findsOneWidget);

      await tester.pump(oneSecond);
      expect(find.text(_cooldownLabel(58)), findsOneWidget);
      expect(_isEnabled(tester), isFalse);

      await tester.tap(find.text(_cooldownLabel(58)));
      expect(harness.sendPresses, 0);

      await tester.pump(const Duration(seconds: 58));
    },
  );

  testWidgets(
    'when the countdown reaches zero then the resend button is enabled',
    (tester) async {
      final harness = _Harness();
      await tester.pumpWidget(harness.build(tester));

      harness.sendSucceeded(tester);
      await tester.pump();

      await tester.pump(const Duration(seconds: 59));
      expect(find.text(_cooldownLabel(1)), findsOneWidget);
      expect(_isEnabled(tester), isFalse);

      await tester.pump(oneSecond);
      expect(find.text(_resendLabel), findsOneWidget);
      expect(_isEnabled(tester), isTrue);

      await tester.tap(find.text(_resendLabel));
      expect(harness.sendPresses, 1);

      // لا يبقى أي مؤقت يعمل بعد انتهاء المهلة.
      await tester.pump(const Duration(minutes: 5));
      expect(find.text(_resendLabel), findsOneWidget);
    },
  );

  testWidgets(
    'when a second send succeeds then the countdown restarts from 60',
    (tester) async {
      final harness = _Harness();
      await tester.pumpWidget(harness.build(tester));

      harness.sendSucceeded(tester);
      await tester.pump();
      await tester.pump(const Duration(seconds: 60));
      expect(find.text(_resendLabel), findsOneWidget);

      // إعادة الإرسال: isPhoneCodeSent يبقى true، والذي يتغير هو الوقت فقط.
      harness.update(() => harness.isSendingPhoneCode = true);
      await tester.pump();
      expect(find.text(_sendingLabel), findsOneWidget);
      expect(_isEnabled(tester), isFalse);

      await tester.pump(const Duration(seconds: 2));
      harness.sendSucceeded(tester);
      await tester.pump();

      expect(find.text(_cooldownLabel(60)), findsOneWidget);
      expect(_isEnabled(tester), isFalse);

      await tester.pump(const Duration(seconds: 10));
      expect(find.text(_cooldownLabel(50)), findsOneWidget);

      // إرسال ناجح ثالث أثناء العدّ يعيده من البداية أيضًا.
      harness.sendSucceeded(tester);
      await tester.pump();
      expect(find.text(_cooldownLabel(60)), findsOneWidget);

      await tester.pump(const Duration(seconds: 60));
      expect(find.text(_resendLabel), findsOneWidget);
      expect(_isEnabled(tester), isTrue);
    },
  );

  testWidgets(
    'when the BLoC resets isPhoneCodeSent while resending then the '
    'countdown still restarts after success',
    (tester) async {
      final harness = _Harness();
      await tester.pumpWidget(harness.build(tester));

      harness.sendSucceeded(tester);
      await tester.pump();
      await tester.pump(const Duration(seconds: 60));

      harness.update(() {
        harness.isSendingPhoneCode = true;
        harness.isPhoneCodeSent = false;
      });
      await tester.pump();

      harness.sendSucceeded(tester);
      await tester.pump();

      expect(find.text(_cooldownLabel(60)), findsOneWidget);

      await tester.pump(const Duration(seconds: 60));
    },
  );

  testWidgets(
    'when the first send fails then no countdown starts',
    (tester) async {
      final harness = _Harness();
      await tester.pumpWidget(harness.build(tester));

      harness.update(() => harness.isSendingPhoneCode = true);
      await tester.pump();
      expect(_isEnabled(tester), isFalse);

      // فشل الإرسال: لا وقت إرسال جديد.
      harness.update(() => harness.isSendingPhoneCode = false);
      await tester.pump();

      expect(find.text(_sendLabel), findsOneWidget);
      expect(_isEnabled(tester), isTrue);

      await tester.pump(const Duration(seconds: 5));
      expect(find.text(_sendLabel), findsOneWidget);
    },
  );

  testWidgets(
    'when a resend fails then the running countdown is neither reset nor '
    'restarted',
    (tester) async {
      final harness = _Harness();
      await tester.pumpWidget(harness.build(tester));

      harness.sendSucceeded(tester);
      await tester.pump();
      await tester.pump(const Duration(seconds: 60));
      expect(_isEnabled(tester), isTrue);

      harness.update(() => harness.isSendingPhoneCode = true);
      await tester.pump();
      harness.update(() => harness.isSendingPhoneCode = false);
      await tester.pump();

      expect(find.text(_resendLabel), findsOneWidget);
      expect(_isEnabled(tester), isTrue);
    },
  );

  testWidgets(
    'when the widget rebuilds for unrelated reasons then the countdown is '
    'not reset',
    (tester) async {
      final harness = _Harness();
      await tester.pumpWidget(harness.build(tester));

      harness.sendSucceeded(tester);
      await tester.pump();
      await tester.pump(const Duration(seconds: 20));
      expect(find.text(_cooldownLabel(40)), findsOneWidget);

      // إعادة بناء بنفس وقت الإرسال (كتابة في الحقل، بدء التحقق، ...).
      harness.update(() => harness.isVerifyingPhone = true);
      await tester.pump();
      expect(find.text(_cooldownLabel(40)), findsOneWidget);

      harness.update(() => harness.isVerifyingPhone = false);
      await tester.pump();
      await tester.enterText(find.byType(TextFormField).last, '1234');
      await tester.pump();
      expect(find.text(_cooldownLabel(40)), findsOneWidget);

      // وقت مساوٍ في القيمة (كائن جديد) لا يعيد العدّ أيضًا.
      harness.update(() {
        harness.codeSentAt = DateTime.fromMicrosecondsSinceEpoch(
          harness.codeSentAt!.microsecondsSinceEpoch,
          isUtc: true,
        );
      });
      await tester.pump(const Duration(seconds: 5));
      expect(find.text(_cooldownLabel(35)), findsOneWidget);

      await tester.pump(const Duration(seconds: 35));
      expect(find.text(_resendLabel), findsOneWidget);
    },
  );

  testWidgets(
    'when the cooldown is over then the button stays disabled while '
    'sending, verifying or submitting',
    (tester) async {
      final harness = _Harness();
      await tester.pumpWidget(harness.build(tester));

      harness.sendSucceeded(tester);
      await tester.pump();
      await tester.pump(const Duration(seconds: 60));
      expect(_isEnabled(tester), isTrue);

      harness.update(() => harness.isVerifyingPhone = true);
      await tester.pump();
      expect(_isEnabled(tester), isFalse);

      harness.update(() {
        harness.isVerifyingPhone = false;
        harness.isSubmitting = true;
      });
      await tester.pump();
      expect(_isEnabled(tester), isFalse);

      harness.update(() {
        harness.isSubmitting = false;
        harness.isSendingPhoneCode = true;
      });
      await tester.pump();
      expect(_isEnabled(tester), isFalse);

      harness.update(() => harness.isSendingPhoneCode = false);
      await tester.pump();
      expect(_isEnabled(tester), isTrue);
    },
  );

  testWidgets(
    'when the section is disposed during the countdown then its timer is '
    'cancelled',
    (tester) async {
      final harness = _Harness();
      await tester.pumpWidget(harness.build(tester));

      harness.sendSucceeded(tester);
      await tester.pump();
      await tester.pump(const Duration(seconds: 5));
      expect(find.text(_cooldownLabel(55)), findsOneWidget);

      harness.update(() => harness.showSection = false);
      await tester.pump();
      expect(find.byType(CheckoutPhoneSection), findsNothing);

      // مؤقت لم يُلغَ كان سيستدعي setState بعد dispose هنا، وإطار الاختبار
      // يفشل أيضًا إذا بقي مؤقت معلّق عند نهاية الاختبار.
      await tester.pump(const Duration(seconds: 120));
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'when the section is recreated during the countdown then it resumes '
    'from the send time instead of restarting',
    (tester) async {
      final harness = _Harness();
      await tester.pumpWidget(harness.build(tester));

      harness.sendSucceeded(tester);
      await tester.pump();
      await tester.pump(const Duration(seconds: 25));

      // مفتاح جديد = عنصر جديد بحالة جديدة (كما يحدث عند التمرير).
      harness.update(() => harness.sectionKey = const ValueKey('recreated'));
      await tester.pump();

      expect(find.text(_cooldownLabel(35)), findsOneWidget);

      await tester.pump(const Duration(seconds: 35));
      expect(find.text(_resendLabel), findsOneWidget);
      expect(_isEnabled(tester), isTrue);
    },
  );

  testWidgets(
    'when the phone is verified then the send button and countdown are '
    'removed',
    (tester) async {
      final harness = _Harness();
      await tester.pumpWidget(harness.build(tester));

      harness.sendSucceeded(tester);
      await tester.pump();
      await tester.pump(const Duration(seconds: 10));

      // نجاح التوثيق: الـ BLoC يمسح وقت الإرسال.
      harness.update(() {
        harness.isPhoneVerified = true;
        harness.isPhoneCodeSent = false;
        harness.codeSentAt = null;
      });
      await tester.pump();

      expect(find.bySubtype<OutlinedButton>(), findsNothing);
      expect(find.text('تم توثيق رقم هاتفك بنجاح.'), findsOneWidget);

      await tester.pump(const Duration(seconds: 120));
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'when the send time is in the future then the countdown never exceeds '
    '60 seconds',
    (tester) async {
      final harness = _Harness();
      await tester.pumpWidget(harness.build(tester));

      harness.update(() {
        harness.isPhoneCodeSent = true;
        harness.codeSentAt = tester.binding.clock.now().add(
          const Duration(hours: 3),
        );
      });
      await tester.pump();

      expect(find.text(_cooldownLabel(60)), findsOneWidget);

      harness.update(() => harness.showSection = false);
      await tester.pump();
    },
  );
}
