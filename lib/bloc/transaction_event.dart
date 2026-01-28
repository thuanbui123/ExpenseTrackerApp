import 'package:equatable/equatable.dart';

import '../models/transaction.dart';

abstract class TransactionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddTransaction extends TransactionEvent {
  final String title;
  final double amount;

  AddTransaction(this.title, this.amount);

  @override
  List<Object> get props => [title, amount];
}

class DeleteTransaction extends TransactionEvent {
  final int id;

  DeleteTransaction({required this.id});

  @override
  List<Object> get props => [id];
}

class UpdateTransaction extends TransactionEvent {
  final Transaction transaction;

  UpdateTransaction(this.transaction);

  @override
  List<Object> get props => [transaction];
}

class LoadTransactions extends TransactionEvent {}
