import 'package:expense_tracker_app/bloc/todo_event.dart';
import 'package:expense_tracker_app/bloc/todo_state.dart';
import 'package:expense_tracker_app/models/todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../helpers/db_helper.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoState(todos: [])) {
    on<LoadTodos>((event, emit) async {
      emit(TodoState(todos: state.todos, isLoading: true));
      try {
        // await Future.delayed(const Duration(milliseconds: 500));
        final dataList = await DBHelper.getData(DBHelper.todoTable);
        final todos = dataList.map((item) => Todo.fromMap(item)).toList();
        emit(TodoState(todos: todos, isLoading: false));
      } catch (e) {
        emit(TodoState(todos: state.todos, isLoading: false));
      }
    });

    on<AddTodo>((event, emit) async {
      final newTodo = Todo(title: event.title, note: event.note, startAt: event.startAt, dueDate: event.dueDate, priority: event.priority, isCompleted: event.isCompleted, createdAt: DateTime.now());
      await DBHelper.insert(DBHelper.todoTable, newTodo.toMap());
      final dataList = await DBHelper.getData(DBHelper.todoTable);
      final updatedTxs = dataList.map((item) => Todo.fromMap(item)).toList();
      emit(TodoState(todos: updatedTxs));
    });

    on<DeleteTodo>((event, emit) async {
      await DBHelper.delete(DBHelper.todoTable, event.id);

      final updatedList = state.todos.where((tx) => tx.id != event.id).toList();

      emit(TodoState(todos: updatedList));
    });

    on<UpdateTodo>((event, emit) async {
      await DBHelper.update(DBHelper.todoTable, event.todo.toMap());

      final updatedList = state.todos.map((tx) {
        return tx.id == event.todo.id ? event.todo : tx;
      }).toList();

      emit(TodoState(todos: updatedList));
    });

    on<ToggleTodoStatus>((event, emit) async {
      final updatedTodo = event.todo.CopyWith(isCompleted: !event.todo.isCompleted);

      await DBHelper.update(DBHelper.todoTable, updatedTodo.toMap());

      final updatedList = state.todos.map((t) {
        return t.id == updatedTodo.id ? updatedTodo : t;
      }).toList();

      emit(TodoState(todos: updatedList));
    });
  }
}
