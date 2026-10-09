import 'package:flutter/material.dart';

class AppConstants {
  // الألوان الأساسية - لكي تغير لون التطبيق مستقبلاً من مكان واحد فقط
  static const Color primaryColor = Colors.teal;
  static const Color incomeColor = Colors.green;
  static const Color expenseColor = Colors.red;

  // ستايل النصوص
  static const TextStyle headingStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle balanceStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );
}