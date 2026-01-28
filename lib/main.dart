import 'package:expense_tracker_app/widgets/new_transaction.dart';
import 'package:expense_tracker_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/transaction_bloc.dart';
import 'bloc/transaction_event.dart';

void main() {
  runApp(BlocProvider(create: (context) => TransactionBloc()..add(LoadTransactions()), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(primarySwatch: Colors.deepPurple, useMaterial3: true),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) {
        return const NewTransaction();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quản lý chi tiêu'), backgroundColor: Theme.of(context).colorScheme.inversePrimary),
      body: const TransactionList(),
      floatingActionButton: FloatingActionButton(onPressed: () => _startAddNewTransaction(context), child: const Icon(Icons.add)),
    );
  }
}
