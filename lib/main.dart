import 'package:expense_tracker_app/widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/navigation_cfg.dart';
import 'bloc/todo_bloc.dart';
import 'bloc/todo_event.dart';
import 'bloc/transaction_bloc.dart';
import 'bloc/transaction_event.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<TransactionBloc>(create: (context) => TransactionBloc()..add(LoadTransactions())),
        BlocProvider<TodoBloc>(create: (context) => TodoBloc()..add(LoadTodos())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quản lý chi tiêu',
      theme: ThemeData(primarySwatch: Colors.deepPurple, useMaterial3: true),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Lấy item hiện tại từ config
    final currentItem = appNavConfig[_selectedIndex];

    return Scaffold(
      appBar: AppBar(title: Text(currentItem.title), backgroundColor: Theme.of(context).colorScheme.inversePrimary),
      body: IndexedStack(index: _selectedIndex, children: appNavConfig.map((item) => item.page).toList()),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: Colors.deepPurple,
        items: appNavConfig.map((item) => BottomNavigationBarItem(icon: Icon(item.icon), label: item.title)).toList(),
      ),
    );
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => const NewTransaction(),
    );
  }
}
