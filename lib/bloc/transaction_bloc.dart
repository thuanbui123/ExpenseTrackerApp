import 'package:expense_tracker_app/bloc/transaction_event.dart';
import 'package:expense_tracker_app/bloc/transaction_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../helpers/db_helper.dart';
import '../models/transaction.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionState(transactions: [])) {
    on<LoadTransactions>((event, emit) async {
      emit(TransactionState(transactions: state.transactions, isLoading: true));
      try {
        // await Future.delayed(const Duration(milliseconds: 500));
        final dataList = await DBHelper.getData(DBHelper.tableName);
        final txs = dataList.map((item) => Transaction(id: item['id'], title: item['title'], amount: item['amount'], date: DateTime.parse(item['date']))).toList();
        emit(TransactionState(transactions: txs, isLoading: false));
      } catch (e) {
        emit(TransactionState(transactions: state.transactions, isLoading: false));
      }
    });

    on<AddTransaction>((event, emit) async {
      final newTx = Transaction(title: event.title, amount: event.amount, date: DateTime.now());
      await DBHelper.insert(DBHelper.tableName, newTx.toMap());
      final dataList = await DBHelper.getData(DBHelper.tableName);
      final updatedTxs = dataList.map((item) => Transaction.fromMap(item)).toList();
      emit(TransactionState(transactions: updatedTxs));
    });

    on<DeleteTransaction>((event, emit) async {
      await DBHelper.delete(DBHelper.tableName, event.id);

      final updatedList = state.transactions.where((tx) => tx.id != event.id).toList();

      emit(TransactionState(transactions: updatedList));
    });

    on<UpdateTransaction>((event, emit) async {
      await DBHelper.update(DBHelper.tableName, event.transaction.toMap());

      final updatedList = state.transactions.map((tx) {
        return tx.id == event.transaction.id ? event.transaction : tx;
      }).toList();

      emit(TransactionState(transactions: updatedList));
    });
  }
}
