import 'package:expense_tracker_app/bloc/transaction_event.dart';
import 'package:expense_tracker_app/bloc/transaction_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/transaction.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionState(transactions: [])) {
    on<AddTransaction>((event, emit) {
      final newTx = Transaction(title: event.title, amount: event.amount, date: DateTime.now());
      final updateList = List<Transaction>.from(state.transactions)..add(newTx);
      emit(TransactionState(transactions: updateList));
    });
  }
}
