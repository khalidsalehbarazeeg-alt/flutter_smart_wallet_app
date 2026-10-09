import 'package:flutter/material.dart';
import '../core/app_constants.dart'; // استيراد الثوابت

class BalanceCard extends StatelessWidget {
  final double totalBalance;
  final double income;
  final double expenses;

  const BalanceCard({
    super.key,
    required this.totalBalance,
    required this.income,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // استخدام ستايل العناوين من الثوابت
            Text('إجمالي الرصيد', style: AppConstants.headingStyle),
            const SizedBox(height: 10),
            Text(
              '${totalBalance.toStringAsFixed(2)} ر.ي',
              // استخدام ستايل الرصيد من الثوابت
              style: AppConstants.balanceStyle,
            ),
            const Divider(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // استخدام ألوان الدخل والمصاريف من الثوابت
                _buildInfoItem('الدخل', income, AppConstants.incomeColor),
                _buildInfoItem('المصاريف', expenses, AppConstants.expenseColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // دالة مساعدة لبناء عناصر الواجهة (تطبيق لمبدأ Reusability)
  Widget _buildInfoItem(String label, double amount, Color color) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 5),
        Text(
          '${amount.toStringAsFixed(2)} ر.ي',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}