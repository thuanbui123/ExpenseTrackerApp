import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/transaction_bloc.dart';
import '../bloc/transaction_event.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({super.key});
  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  void _submitData() {
    final title = _titleController.text;
    final enteredAmount = double.tryParse(_amountController.text) ?? 0;

    if (title.isEmpty || enteredAmount <= 0) {
      return;
    }

    context.read<TransactionBloc>().add(AddTransaction(title, enteredAmount));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 20, left: 20, right: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Thêm chi tiêu mới', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

          TextField(
            decoration: const InputDecoration(labelText: "Tên khoản chi"),
            controller: _titleController,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Số tiền (VNĐ)'),
            controller: _amountController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: _submitData, child: const Text('Lưu giao dịch')),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
