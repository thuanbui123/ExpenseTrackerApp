import 'package:expense_tracker_app/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';

class NewTodo extends StatefulWidget {
  final Todo? editingTodo;
  const NewTodo({super.key, this.editingTodo});
  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();

  DateTime _startAt = DateTime.now();
  DateTime _dueDate = DateTime.now().add(const Duration(days: 1));
  TodoPriority _priority = TodoPriority.low;
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();

    if (widget.editingTodo != null) {
      _titleController.text = widget.editingTodo!.title;
      _titleController.text = widget.editingTodo?.title ?? '';
      _noteController.text = widget.editingTodo?.note ?? '';
      _startAt = widget.editingTodo?.startAt ?? DateTime.now();
      _dueDate = widget.editingTodo?.dueDate ?? DateTime.now().add(const Duration(days: 1));
      _priority = widget.editingTodo?.priority ?? TodoPriority.medium;
      _isCompleted = widget.editingTodo?.isCompleted ?? false;
    }
  }

  Future<void> _pickDate(BuildContext context, bool isStartDate) async {
    final picked = await showDatePicker(context: context, initialDate: isStartDate ? _startAt : _dueDate, firstDate: DateTime(2025), lastDate: DateTime(2030));
    if (picked != null) {
      setState(() {
        if (isStartDate)
          _startAt = picked;
        else
          _dueDate = picked;
      });
    }
  }

  void _submitData() {
    final title = _titleController.text;
    if (title.isEmpty) return;

    if (widget.editingTodo == null) {
      // TRƯỜNG HỢP THÊM MỚI: Gửi event AddTodo
      context.read<TodoBloc>().add(AddTodo(title: title, note: _noteController.text, startAt: _startAt, dueDate: _dueDate, priority: _priority, isCompleted: _isCompleted));
    } else {
      // TRƯỜNG HỢP CHỈNH SỬA: Gửi event UpdateTodo
      final updatedTodo = Todo(id: widget.editingTodo!.id, title: title, note: _noteController.text, startAt: _startAt, dueDate: _dueDate, priority: _priority, isCompleted: _isCompleted, createdAt: widget.editingTodo!.createdAt);
      context.read<TodoBloc>().add(UpdateTodo(updatedTodo));
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 20, left: 20, right: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.editingTodo == null ? 'Công việc mới' : 'Chỉnh sửa', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Tiêu đề'),
            ),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(labelText: 'Ghi chú'),
              maxLines: 2,
            ),
            const SizedBox(height: 15),

            // Chọn Start At và Due Date
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Bắt đầu', style: TextStyle(fontSize: 12)),
                    subtitle: Text(DateFormat('dd/MM/yy').format(_startAt)),
                    onTap: () => _pickDate(context, true),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Hạn chót', style: TextStyle(fontSize: 12)),
                    subtitle: Text(DateFormat('dd/MM/yy').format(_dueDate)),
                    onTap: () => _pickDate(context, false),
                  ),
                ),
              ],
            ),

            // Chọn mức độ ưu tiên
            const Text('Mức độ ưu tiên', style: TextStyle(fontSize: 14, color: Colors.grey)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: TodoPriority.values.map((p) => ChoiceChip(label: Text(p.name), selected: _priority == p, onSelected: (val) => setState(() => _priority = p))).toList(),
            ),

            // Trạng thái hoàn thành (Chỉ hiện khi sửa)
            if (widget.editingTodo != null) SwitchListTile(title: const Text('Đã hoàn thành'), value: _isCompleted, onChanged: (val) => setState(() => _isCompleted = val)),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: _submitData, child: const Text('Lưu thay đổi')),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
