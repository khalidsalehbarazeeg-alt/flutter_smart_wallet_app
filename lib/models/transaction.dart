import 'package:uuid/uuid.dart';

// تعريف أنواع العمليات المالية (Enum)
// هذا المبدأ يمنع الأخطاء الإملائية في نوع العملية ويجعل الكود "نظيفاً"
enum TransactionType { income, expense }

class Transaction {
  final String id;
  final String title;       // اسم العملية (مثلاً: راتب، مواصلات)
  final double amount;      // المبلغ
  final DateTime date;      // تاريخ العملية
  final TransactionType type; // هل هي (دخل) أم (مصروف)

  Transaction({
    String? id,             // الـ ID اختياري لأنه سيتم توليده تلقائياً
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
  }) : id = id ?? const Uuid().v4(); // توليد معرف فريد باستخدام مكتبة uuid
}