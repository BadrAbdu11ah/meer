import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meer_flutter/presentation/auth/login/bloc/login_bloc.dart';
import 'package:meer_flutter/presentation/auth/login/components/confirm_button.dart';
import 'package:meer_flutter/presentation/auth/login/components/custom_divider.dart';
import 'package:meer_flutter/presentation/auth/login/components/custom_google_button.dart';
import 'package:meer_flutter/presentation/auth/login/components/description.dart';
import 'package:meer_flutter/presentation/auth/login/components/logo.dart';
import 'package:meer_flutter/presentation/auth/login/components/phone_field.dart';

class LoginView extends StatelessWidget {
  final bool isLoading;
  final TextEditingController phoneController;
  final FocusNode phoneFocusNode;
  const LoginView({
    super.key,
    required this.isLoading,
    required this.phoneController,
    required this.phoneFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    // // جلب ألوان الثيم الحالي للتطبيق
    final colors = Theme.of(context).colorScheme;

    return Stack(
      children: [
        // // المحتوى الرئيسي للشاشة
        Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // // شعار أو اسم التطبيق
                Logo(
                  title: 'مـيــر',
                  colors: colors,
                ),
                const SizedBox(height: 8),
                // // الوصف القصير لمشروع مير
                Description(
                  colors: colors,
                  title: 'سوق الأسر المنتجة والمناديب',
                ),
                const SizedBox(height: 40),
                // // زر تسجيل الدخول المخصص بجوجل
                CustomGoogleButton(
                  colors: colors,
                  title: 'المتابعة باستخدام حساب جوجل',
                  onGoogle: () => context.read<LoginBloc>().add(
                    const GoogleSignInRequested(),
                  ),
                ),
                const SizedBox(height: 24),
                // // فاصل (أو) لترتيب الواجهة
                CustomDivider(
                  colors: colors,
                ),
                const SizedBox(height: 24),
                // // حقل الهاتف مع تمرير الـ FocusNode والمتحكم
                PhoneField(
                  controller: phoneController,
                  focusNode: phoneFocusNode,
                  invalidMessage: "يجب أن يكون 10 أرقام",
                ),
                const SizedBox(height: 20),
                // // زر التأكيد بعرض متناسق
                ConfirmButton(
                  colors: colors,
                  onConfirm: () {
                    final phone = phoneController.text.trim();
                    if (phone.isNotEmpty) {
                      context.read<LoginBloc>().add(
                        LoginEvent.sendOtpRequested(phone: phone),
                      );
                    }
                  },
                  title: "تأكيد رقم الجوال",
                ),
              ],
            ),
          ),
        ),

        // // طبقة التحميل والشاشة المعتمة (تغطي الشاشة بالكامل عند التحميل)
        if (isLoading) ...[
          const ModalBarrier(
            dismissible: false,
            color: Colors.black26,
          ),
          Center(
            child: SizedBox(
              height: 36,
              width: 36,
              child: CircularProgressIndicator(
                color: colors.primary,
                strokeWidth: 3,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
