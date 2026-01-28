import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/transaction_bloc.dart';
import '../bloc/transaction_event.dart';
import '../models/transaction.dart';

class NewTransaction extends StatefulWidget {
  final Transaction? editingTx;
  const NewTransaction({super.key, this.editingTx});
  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Nếu là chế độ sửa, đổ dữ liệu cũ vào form
    if (widget.editingTx != null) {
      _titleController.text = widget.editingTx!.title;
      _amountController.text = widget.editingTx!.amount.toString();
    }
  }

  void _submitData() {
    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text) ?? 0;

    if (title.isEmpty || amount <= 0) {
      return;
    }

    if (widget.editingTx == null) {
      // Thêm mới
      context.read<TransactionBloc>().add(AddTransaction(title, amount));
    } else {
      // Cập nhật
      final updatedTx = Transaction(
        id: widget.editingTx!.id,
        title: title,
        amount: amount,
        date: widget.editingTx!.date, // Giữ nguyên ngày cũ hoặc DateTime.now() tùy bạn
      );
      context.read<TransactionBloc>().add(UpdateTransaction(updatedTx));
    }
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
