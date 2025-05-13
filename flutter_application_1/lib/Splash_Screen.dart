import 'package:flutter/material.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // الانتقال التلقائي بعد 3 ثواني
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3  ), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      });
    });

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      body: Center(
        child: ClipOval(
          child: Image.asset(
            'assets/tripella.png', // تأكد من أن الصورة لديك موجودة هنا
            width: 280,
            height: 280,
            fit: BoxFit.cover, // لضمان ملء الصورة داخل الدائرة
          ),
        ),
      ),
    );
  }
}
