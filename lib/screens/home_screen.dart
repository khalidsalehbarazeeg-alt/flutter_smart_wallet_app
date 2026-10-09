import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wallet_provider.dart';
import '../widgets/balance_card.dart';
import '../models/transaction.dart';
import '../core/app_constants.dart'; // استيراد الثوابت
import 'add_transaction_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wallet = Provider.of<WalletProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'محفظتي المالية',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Column(
        children: [
          // عرض بطاقة الرصيد باستخدام البيانات من الـ Provider
          BalanceCard(
            totalBalance: wallet.totalBalance,
            income: wallet.totalIncome,
            expenses: wallet.totalExpenses,
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'آخر العمليات',
                style: AppConstants.headingStyle, // استخدام الستايل من الـ Core
              ),
            ),
          ),

          Expanded(
            child: wallet.transactions.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
              itemCount: wallet.transactions.length,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemBuilder: (context, index) {
                final tx = wallet.transactions[index];
                // تحديد اللون بناءً على نوع العملية من الثوابت
                final color = tx.type == TransactionType.income
                    ? AppConstants.incomeColor
                    : AppConstants.expenseColor;

                return Card(
                  elevation: 1,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: color.withOpacity(0.1),
                      child: Icon(
                        tx.type == TransactionType.income
                            ? Icons.arrow_downward
                            : Icons.arrow_upward,
                        color: color,
                      ),
                    ),
                    title: Text(
                      tx.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        '${tx.date.day}/${tx.date.month}/${tx.date.year}'),
                    trailing: Text(
                      '${tx.type == TransactionType.income ? '+' : '-'} ${tx.amount.toStringAsFixed(2)} ر.ي',
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AddTransactionScreen()),
          );
        },
        backgroundColor: AppConstants.primaryColor, // استخدام لون الثيم الأساسي
        tooltip: 'إضافة عملية',
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // واجهة حالة القائمة الفارغة
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.account_balance_wallet_outlined,
              size: 80, color: Colors.grey[300]),
          const SizedBox(height: 10),
          const Text(
            'لا توجد عمليات مسجلة حالياً',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}