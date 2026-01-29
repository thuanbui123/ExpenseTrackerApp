import 'package:flutter/material.dart';

import '../config/navigation_cfg.dart';

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
        iconSize: 24,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(color: Colors.black54),
        showUnselectedLabels: true,
        items: appNavConfig.map((item) => BottomNavigationBarItem(icon: Icon(item.icon), label: item.title)).toList(),
      ),
    );
  }
}
