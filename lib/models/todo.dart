enum TodoPriority { low, medium, high }

class Todo {
  final int? id;
  final String title;
  final String note;
  final DateTime startAt;
  final DateTime dueDate;
  final TodoPriority priority;
  final bool isCompleted;
  final DateTime createdAt;
  Todo({this.id, required this.title, required this.note, required this.startAt, required this.dueDate, this.priority = TodoPriority.medium, this.isCompleted = false, required this.createdAt});

  Todo CopyWith({int? id, String? title, String? note, DateTime? startAt, DateTime? dueDate, TodoPriority? priority, bool? isCompleted}) {
    return Todo(id: id ?? this.id, title: title ?? this.title, note: note ?? this.note, startAt: startAt ?? this.startAt, dueDate: dueDate ?? this.dueDate, priority: priority ?? this.priority, isCompleted: isCompleted ?? this.isCompleted, createdAt: createdAt);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'note': note, 'startAt': startAt.toIso8601String(), 'dueDate': dueDate.toIso8601String(), 'isCompleted': isCompleted ? 1 : 0, 'priority': priority.index, 'createdAt': createdAt.toIso8601String()};
  }

  factory Todo.fromMap(Map<String, dynamic> item) {
    return Todo(id: item['id'], title: item['title'], note: item['note'], startAt: DateTime.parse(item['startAt'] as String), dueDate: DateTime.parse(item['dueDate'] as String), priority: TodoPriority.values[item['priority'] as int], isCompleted: (item['isCompleted'] as int) == 1, createdAt: DateTime.parse(item['createdAt'] as String));
  }
}
