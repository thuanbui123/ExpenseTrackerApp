import 'package:expense_tracker_app/bloc/transaction_bloc.dart';
import 'package:expense_tracker_app/bloc/transaction_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionList extends StatelessWidget {
  // final List<Transaction> transactions;

  // const TransactionList(this.transactions, {super.key});
  const TransactionList({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        final txs = state.transactions;

        return txs.isEmpty
            ? const Center(child: Text('Chưa có giao dịch nào được thêm!', style: TextStyle(fontSize: 16)))
            : ListView.builder(
                itemCount: txs.length,
                itemBuilder: (ctx, index) {
                  return Card(
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
                        '${txs[index].amount}đ',
                        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
