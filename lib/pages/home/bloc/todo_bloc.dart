import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todoku_app/pages/home/model/todo.dart';
import 'package:todoku_app/repository/todos_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _todoRepository;

  TodoBloc(this._todoRepository) : super(TodoInitial()) {
    on<LoadTodosEvent>(_onLoadTodo);
    on<AddTodoEvent>(_onAddTodo);
    on<UpdateTodoEvent>(_onUpdateTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
  }

  void _onLoadTodo(LoadTodosEvent event, Emitter<TodoState> emit) async {
    try {
      emit(TodoLoading());
      final todos = await _todoRepository.getTodos().first;
      emit(TodoLoaded(todos));
    } catch (e) {
      emit(TodoError('Failed to load todos.'));
    }
  }

  void _onAddTodo(AddTodoEvent event, Emitter<TodoState> emit) async {
    try {
      emit(TodoLoading());
      await _todoRepository.addTodo(event.todo);
      emit(TodoSuccess('Todo added successfully.'));
    } catch (e) {
      emit(TodoError('Failed to add todo.'));
    }
  }

  void _onUpdateTodo(UpdateTodoEvent event, Emitter<TodoState> emit) async {
    try {
      emit(TodoLoading());
      await _todoRepository.updateTodo(event.todo);
      emit(TodoSuccess('Todo updated successfully.'));
    } catch (e) {
      emit(TodoError('Failed to update todo.'));
    }
  }

  void _onDeleteTodo(DeleteTodoEvent event, Emitter<TodoState> emit) async {
    try {
      emit(TodoLoading());
      await _todoRepository.deleteTodo(event.todoId);
      emit(TodoSuccess('Todo deleted successfully.'));
    } catch (e) {
      emit(TodoError('Failed to delete todo.'));
    }
  }
}
