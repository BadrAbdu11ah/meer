import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meer_flutter/presentation/auth/verify_otp/bloc/verify_otp_bloc.dart';
import 'package:pinput/pinput.dart';

class VerifyOtpView extends StatelessWidget {
  final bool isLoading;
  final String phoneController;
  final ColorScheme colors;

  const VerifyOtpView({
    super.key,
    required this.phoneController,
    required this.isLoading,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "قم بادخال الرمز الذي تم ارساله",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "0$phoneController",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Pinput(
                  keyboardType: TextInputType.phone,
                  length: 4, // عدد الخانات
                  showCursor: true, // إظهار المؤشر
                  autofocus: true, // تفعيل التركيز التلقائي على الخانة الأولى
                  onCompleted: (pin) {
                    // 1. استدعاء دالة التحقق عند اكتمال الإدخال
                    context.read<VerifyOtpBloc>().add(
                      VerifyOtpRequested(phone: phoneController, code: pin),
                    );
                  },
                  defaultPinTheme: PinTheme(
                    width: 56, // العرض
                    height: 56, // الطول
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ), // تنسيق النص
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // لون الخلفية
                      borderRadius: BorderRadius.circular(10), // الاستدارة
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
