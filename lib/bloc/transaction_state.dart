import '../models/transaction.dart';

class TransactionState {
  final List<Transaction> transactions;
  final bool isLoading;
  TransactionState({required this.transactions, this.isLoading = false});
}
