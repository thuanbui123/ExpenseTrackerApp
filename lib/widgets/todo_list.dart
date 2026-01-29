import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import '../bloc/todo_state.dart';
import '../helpers/ui_helper.dart';
import '../models/todo.dart';
import 'new_todo.dart';

class TodoList extends StatelessWidget {
  TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Danh sách công việc')),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          final txs = state.todos;
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return txs.isEmpty
              ? const Center(child: Text('Chưa có công việc nào!', style: TextStyle(fontSize: 16)))
              : ListView.builder(
                  itemCount: txs.length,
                  itemBuilder: (ctx, index) {
                    final tx = txs[index];
                    return GestureDetector(
                      onLongPress: () => _showActionMenu(context, tx),
                      child: Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          leading: IconButton(
                            icon: Icon(tx.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked, color: tx.isCompleted ? Colors.green : Colors.grey),
                            onPressed: () {
                              context.read<TodoBloc>().add(ToggleTodoStatus(tx));
                            },
                          ),

                          title: Text(
                            tx.title,
                            style: TextStyle(fontWeight: FontWeight.bold, decoration: tx.isCompleted ? TextDecoration.lineThrough : null, color: tx.isCompleted ? Colors.grey : Colors.black87),
                          ),

                          subtitle: Text('Hạn: ${tx.dueDate.day}/${tx.dueDate.month}/${tx.dueDate.year}', style: TextStyle(color: tx.dueDate.isBefore(DateTime.now()) && !tx.isCompleted ? Colors.red : Colors.grey[600])),

                          trailing: _buildPriorityIndicator(tx.priority),
                        ),
                      ),
                    );
                  },
                );
        },
      ),

      floatingActionButton: FloatingActionButton(onPressed: () => UIHelper.showNewTodoSheet(context), child: const Icon(Icons.add)),
    );
  }
}

void _showActionMenu(BuildContext context, Todo tx) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (ctx) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.blue),
              title: const Text('Chỉnh sửa'),
              onTap: () {
                Navigator.pop(ctx);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => NewTodo(editingTodo: tx),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Xóa công việc'),
              onTap: () {
                Navigator.pop(ctx);
                _confirmDelete(context, tx); // Gọi hàm xác nhận xóa
              },
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildPriorityIndicator(TodoPriority priority) {
  Color color;
  String label;
  switch (priority) {
    case TodoPriority.high:
      color = Colors.red;
      label = 'P1';
      break;
    case TodoPriority.medium:
      color = Colors.orange;
      label = 'P2';
      break;
    default:
      color = Colors.blue;
      label = 'P3';
  }
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
    child: Text(
      label,
      style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 10),
    ),
  );
}

void _confirmDelete(BuildContext context, Todo tx) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Xác nhận xóa'),
      content: Text('Bạn có chắc chắn muốn xóa "${tx.title}" không?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: const Text('Hủy', style: TextStyle(color: Colors.grey)),
        ),
        TextButton(
          onPressed: () {
            // Gửi event xóa vào Bloc
            context.read<TodoBloc>().add(DeleteTodo(id: tx.id!));
            Navigator.of(ctx).pop();

            // Hiện thông báo nhỏ (SnackBar)
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã xóa công việc')));
          },
          child: const Text('Xóa', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}
