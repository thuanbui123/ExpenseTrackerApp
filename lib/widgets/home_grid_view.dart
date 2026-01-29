import 'package:expense_tracker_app/widgets/todo_list.dart';
import 'package:expense_tracker_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import '../config/menu_item.dart';

class HomeGridView extends StatelessWidget {
  const HomeGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<MenuItem> menus = [
      MenuItem(
        title: 'Thu chi',
        icon: Icons.add_moderator,
        color: Colors.green,
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const TransactionList(isPage: true))),
      ),
      MenuItem(
        title: 'Sổ giao dịch',
        icon: Icons.history,
        color: Colors.blue,
        onTap: () {
          // Logic chuyển sang Tab Sổ giao dịch hoặc mở màn hình mới
        },
      ),
      MenuItem(
        title: 'Báo cáo',
        icon: Icons.pie_chart,
        color: Colors.orange,
        onTap: () {
          // Logic mở màn hình Thống kê chi tiết
        },
      ),
      MenuItem(
        title: 'Hạn mức',
        icon: Icons.trending_down,
        color: Colors.redAccent,
        onTap: () {
          // Chức năng thiết lập ngân sách chi tiêu tối đa
        },
      ),
      MenuItem(
        title: 'Công việc',
        icon: Icons.checklist_rtl,
        color: Colors.purple,
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TodoList())),
      ),
      MenuItem(
        title: 'Tài khoản/Ví',
        icon: Icons.account_balance_wallet,
        color: Colors.teal,
        onTap: () {
          // Quản lý các ví tiền hoặc tài khoản ngân hàng
        },
      ),
      MenuItem(
        title: 'Tiết kiệm',
        icon: Icons.savings,
        color: Colors.pink,
        onTap: () {
          // Chức năng quản lý các khoản tiết kiệm (Heo đất)
        },
      ),
      MenuItem(
        title: 'Hạng mục',
        icon: Icons.category,
        color: Colors.amber,
        onTap: () {
          // Quản lý các Category (Ăn uống, Di chuyển, v.v.)
        },
      ),
      MenuItem(
        title: 'Cài đặt',
        icon: Icons.settings,
        color: Colors.grey,
        onTap: () {
          // Mở cài đặt app
        },
      ),
    ];
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.9),
      itemCount: menus.length,
      itemBuilder: (context, index) {
        final item = menus[index];
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: InkWell(
            onTap: item.onTap,
            borderRadius: BorderRadius.circular(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, size: 40, color: item.color),
                const SizedBox(height: 8),
                Text(
                  item.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
