import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meer_flutter/core/constant/app_route.dart';
import 'package:meer_flutter/presentation/auth/login/bloc/login_bloc.dart';
import 'package:meer_flutter/presentation/auth/login/view/login_view.dart';
import 'package:meer_flutter/presentation/auth/verify_otp/view/verify_otp_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // // متحكم النص لاستخراج رقم الهاتف المخزن بالحقل
  final TextEditingController phoneController = TextEditingController();
  // // مراقب تركيز حقل الهاتف
  final FocusNode phoneFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    phoneFocusNode.addListener(() {
      setState(() {}); // // إعادة بناء الواجهة لتحديث الحالة عند التركيز
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // جلب ألوان الثيم الحالي للتطبيق
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          state.whenOrNull(
            error: (errorMessage) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  errorMessage,
                  style: TextStyle(color: colors.onErrorContainer),
                ),
                backgroundColor: colors.errorContainer,
                duration: const Duration(seconds: 4),
              ),
            ),
            otpSent: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'تم إرسال رمز التحقق',
                    style: TextStyle(color: colors.onPrimaryContainer),
                  ),
                  backgroundColor: colors.primaryContainer,
                ),
              );
              Navigator.pushNamed(
                context,
                AppRoute.verifyOtpScreen,
                arguments: phoneController.text,
              );
            },
            authenticated: (userProfile) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'أهلاً بك يا ${userProfile.fullName}',
                    style: TextStyle(color: colors.onPrimaryContainer),
                  ),
                  backgroundColor: colors.primaryContainer,
                ),
              );
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoute.homeScreen,
                (route) => false,
              );
            },
          );
        },
        builder: (context, state) {
          final isLoading = state.maybeWhen(
            loading: () => true,
            orElse: () => false,
          );
          return LoginView(
            isLoading: isLoading,
            phoneController: phoneController,
            phoneFocusNode: phoneFocusNode,
          );
        },
      ),
    );
  }
}
