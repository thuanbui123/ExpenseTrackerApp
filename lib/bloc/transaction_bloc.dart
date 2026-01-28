import 'package:expense_tracker_app/bloc/transaction_event.dart';
import 'package:expense_tracker_app/bloc/transaction_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../helpers/db_helper.dart';
import '../models/transaction.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionState(transactions: [])) {
    on<LoadTransactions>((event, emit) async {
      final dataList = await DBHelper.getData(DBHelper.tableName);
      final txs = dataList.map((item) => Transaction(id: item['id'], title: item['title'], amount: item['amount'], date: DateTime.parse(item['date']))).toList();
      emit(TransactionState(transactions: txs));
    });

    on<AddTransaction>((event, emit) async {
      final newTx = Transaction(title: event.title, amount: event.amount, date: DateTime.now());
      await DBHelper.insert('user_transactions', newTx.toMap());
      final dataList = await DBHelper.getData('user_transactions');
      final updatedTxs = dataList.map((item) => Transaction.fromMap(item)).toList();
      emit(TransactionState(transactions: updatedTxs));
    });
  }
}
