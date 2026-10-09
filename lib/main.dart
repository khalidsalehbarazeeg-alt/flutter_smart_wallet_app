import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/wallet_provider.dart';
import './screens/home_screen.dart';
import './core/app_constants.dart'; // استيراد الثوابت من مجلد core

void main() {
  runApp(
    // ربط الـ Provider بالتطبيق ليكون متاحاً في كل الشاشات
    ChangeNotifierProvider(
      create: (context) => WalletProvider(),
      child: const SmartWalletApp(),
    ),
  );
}

class SmartWalletApp extends StatelessWidget {
  const SmartWalletApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'المحفظة الذكية',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // تم استبدال الألوان هنا بالثوابت لضمان نظافة الكود (Clean Code)
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppConstants.primaryColor,
          primary: AppConstants.primaryColor,
          secondary: Colors.amber, // يمكنك أيضاً إضافة هذا للثوابت إذا أردت
        ),
      ),
      // الشاشة التي ستبدأ عند فتح التطبيق
      home: const HomeScreen(),
    );
  }
}