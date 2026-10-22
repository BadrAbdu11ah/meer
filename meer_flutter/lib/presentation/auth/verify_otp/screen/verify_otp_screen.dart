import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meer_flutter/core/constant/app_route.dart';
import 'package:meer_flutter/presentation/auth/verify_otp/bloc/verify_otp_bloc.dart';
import 'package:meer_flutter/presentation/auth/verify_otp/view/verify_otp_view.dart';

class VerifyOtpScreen extends StatelessWidget {
  final String phone;
  const VerifyOtpScreen({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: BlocConsumer<VerifyOtpBloc, VerifyOtpState>(
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
            authenticated: (userProfile) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'أهلاً بك في تطبيق مــيــر',
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
          return VerifyOtpView(
            phoneController: phone,
            isLoading: isLoading,
            colors: colors,
          );
        },
      ),
    );
  }
}
