import 'package:equatable/equatable.dart';

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
  final String id;

  DeleteTransaction({required this.id});
}
