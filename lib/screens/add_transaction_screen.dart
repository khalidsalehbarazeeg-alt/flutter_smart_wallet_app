import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/transaction.dart';
import '../providers/wallet_provider.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  TransactionType _selectedType = TransactionType.expense;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.tryParse(_amountController.text) ?? 0;

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return; // توقف إذا كانت البيانات خاطئة (Validation)
    }

    // إضافة العملية عبر الـ Provider
    Provider.of<WalletProvider>(context, listen: false).addTransaction(
      Transaction(
        title: enteredTitle,
        amount: enteredAmount,
        date: DateTime.now(),
        type: _selectedType,
      ),
    );

    Navigator.of(context).pop(); // العودة للشاشة السابقة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة عملية جديدة')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'اسم العملية (مثلاً: غداء)'),
            ),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'المبلغ'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('نوع العملية: '),
                ChoiceChip(
                  label: const Text('مصروف'),
                  selected: _selectedType == TransactionType.expense,
                  onSelected: (_) => setState(() => _selectedType = TransactionType.expense),
                ),
                const SizedBox(width: 10),
                ChoiceChip(
                  label: const Text('دخل'),
                  selected: _selectedType == TransactionType.income,
                  onSelected: (_) => setState(() => _selectedType = TransactionType.income),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _submitData,
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
              child: const Text('حفظ العملية'),
            ),
          ],
        ),
      ),
    );
  }
}