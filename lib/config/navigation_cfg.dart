import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/transaction_list.dart';

class NavigationItem {
  final Widget page;
  final String title;
  final IconData icon;
  final bool showFab;

  NavigationItem({required this.page, required this.title, required this.icon, this.showFab = false});
}

final List<NavigationItem> appNavConfig = [
  NavigationItem(page: const TransactionList(), title: 'Chi tiêu', icon: CupertinoIcons.list_bullet, showFab: true),
  NavigationItem(
    page: const Center(child: Text('Thống kê')),
    title: 'Thống kê',
    icon: Icons.bar_chart,
    showFab: false,
  ),
  NavigationItem(
    page: const Center(child: Text('Cài đặt')),
    title: 'Cài đặt',
    icon: Icons.settings,
    showFab: false,
  ),
];
