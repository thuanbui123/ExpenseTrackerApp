import 'package:equatable/equatable.dart';

import '../models/todo.dart';

abstract class TodoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  final String title;
  final String note;
  final DateTime startAt;
  final DateTime dueDate;
  final TodoPriority priority;
  final bool isCompleted;

  AddTodo({required this.title, required this.note, required this.startAt, required this.dueDate, this.priority = TodoPriority.medium, this.isCompleted = false});

  @override
  List<Object> get props => [title, note, startAt, dueDate, priority, isCompleted];
}

class DeleteTodo extends TodoEvent {
  final int id;

  DeleteTodo({required this.id});

  @override
  List<Object> get props => [id];
}

class UpdateTodo extends TodoEvent {
  final Todo todo;

  UpdateTodo(this.todo);

  @override
  List<Object> get props => [todo];
}

class ToggleTodoStatus extends TodoEvent {
  final Todo todo;

  ToggleTodoStatus(this.todo);

  @override
  List<Object> get props => [todo];
}
