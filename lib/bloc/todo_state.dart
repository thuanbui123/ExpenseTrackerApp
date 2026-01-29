import 'package:expense_tracker_app/models/todo.dart';

class TodoState {
  final List<Todo> todos;
  final bool isLoading;
  TodoState({required this.todos, this.isLoading = false});
}
