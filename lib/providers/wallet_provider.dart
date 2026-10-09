import 'package:flutter/material.dart';
import '../models/transaction.dart';

class WalletProvider with ChangeNotifier {
  // قائمة خاصة بالعمليات (Private List) لضمان عدم التلاعب بها من الخارج مباشرة
  final List<Transaction> _transactions = [];

  // دالة لجلب العمليات (Getter)
  List<Transaction> get transactions => [..._transactions];

  // حساب إجمالي الدخل
  double get totalIncome {
    return _transactions
        .where((t) => t.type == TransactionType.income)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  // حساب إجمالي المصاريف
  double get totalExpenses {
    return _transactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  // الرصيد الإجمالي
  double get totalBalance => totalIncome - totalExpenses;

  // إضافة عملية جديدة
  void addTransaction(Transaction tx) {
    _transactions.add(tx);
    // تنبيه التطبيق بأن البيانات تغيرت لتحديث الواجهة (مبدأ Clean State)
    notifyListeners();
  }

  // حذف عملية
  void deleteTransaction(String id) {
    _transactions.removeWhere((tx) => tx.id == id);
    notifyListeners();
  }
}