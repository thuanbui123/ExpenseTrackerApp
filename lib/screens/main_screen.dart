import 'package:flutter/material.dart';

import '../config/navigation_cfg.dart';
import '../widgets/new_transaction.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final currentItem = appNavConfig[_selectedIndex];
    return Scaffold(
      appBar: AppBar(title: Text(currentItem.title), backgroundColor: Theme.of(context).colorScheme.inversePrimary),
      body: IndexedStack(index: _selectedIndex, children: appNavConfig.map((item) => item.page).toList()),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.deepPurple,
        items: appNavConfig.map((item) => BottomNavigationBarItem(icon: Icon(item.icon), label: item.title)).toList(),
      ),
      floatingActionButton: currentItem.showFab ? FloatingActionButton(onPressed: () => _startAddNewTransaction(context), child: const Icon(Icons.add)) : null,
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
