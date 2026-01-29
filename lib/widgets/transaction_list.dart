import 'package:expense_tracker_app/bloc/transaction_bloc.dart';
import 'package:expense_tracker_app/bloc/transaction_state.dart';
import 'package:expense_tracker_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/transaction_event.dart';
import 'new_transaction.dart';

class TransactionList extends StatelessWidget {
  // final List<Transaction> transactions;

  // const TransactionList(this.transactions, {super.key});
  const TransactionList({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        final txs = state.transactions;
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return txs.isEmpty
            ? const Center(child: Text('Chưa có giao dịch nào được thêm!', style: TextStyle(fontSize: 16)))
            : ListView.builder(
                itemCount: txs.length,
                itemBuilder: (ctx, index) {
                  final tx = txs[index];
                  return GestureDetector(
                    onLongPress: () => _showActionMenu(context, tx),
                    child: Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.greenAccent,
                          child: const Icon(Icons.attach_money, color: Colors.white),
                        ),
                        title: Text(txs[index].title, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(txs[index].date.toString()),
                        trailing: Text(
                          '${txs[index].amount.toInt().toString()}đ',
                          style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                },
              );
      },
    );
  }

  void _showActionMenu(BuildContext context, Transaction tx) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit, color: Colors.blue),
                title: const Text('Chỉnh sửa'),
                onTap: () {
                  Navigator.pop(ctx);
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => NewTransaction(editingTx: tx),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Xóa giao dịch'),
                onTap: () {
                  Navigator.pop(ctx);
                  _confirmDelete(context, tx); // Gọi hàm xác nhận xóa
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, Transaction tx) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: Text('Bạn có chắc chắn muốn xóa "${tx.title}" không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Hủy', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              // Gửi event xóa vào Bloc
              context.read<TransactionBloc>().add(DeleteTransaction(id: tx.id!));
              Navigator.of(ctx).pop();

              // Hiện thông báo nhỏ (SnackBar)
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã xóa giao dịch')));
            },
            child: const Text('Xóa', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
