import 'package:expense_tracker_app/widgets/home_grid_view.dart';
import 'package:flutter/material.dart';

class NavigationItem {
  final Widget page;
  final String title;
  final IconData icon;
  final bool showFab;

  NavigationItem({required this.page, required this.title, required this.icon, this.showFab = false});
}

final List<NavigationItem> appNavConfig = [
  NavigationItem(page: const HomeGridView(), title: 'Trang chủ', icon: Icons.home, showFab: true),
  NavigationItem(
    page: const Center(child: Text('Công việc')),
    title: 'Công việc',
    icon: Icons.work,
    showFab: false,
  ),
];
