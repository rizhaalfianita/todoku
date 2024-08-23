import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:todoku_app/models/todo.dart';
import 'package:todoku_app/repository/todos_repository.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodosRepository _repository;

  TodosBloc(this._repository) : super(const TodosLoading()) {
    on<LoadedTodosEvent>((event, emit) async {
      emit(const TodosLoading());
      try {
        final todos = await _repository.getAllTodos();
        emit(TodosLoaded(todos: todos));
      } catch (e) {
        emit(TodosError(
          message: "Failed to load todos ${e.toString()}",
        ));
      }
    });

    on<AddTodoEvent>((event, emit) async {
      emit(const TodosLoading());
      try {
        final result = await _repository.addTodo(event.title);
        if (result) {
          emit(TodosLoaded(todos: await _repository.getAllTodos()));
        }
      } catch (e) {
        emit(TodosError(message: "Failed to add todo ${e.toString()}"));
      }
    });

    on<ToggleTodoCompletionEvent>((event, emit) async {
      emit(const TodosLoading());
      try {
        final updatedTodos =
            await _repository.toggleTodoCompletion(event.index);
        if (updatedTodos != null) {
          emit(TodosLoaded(todos: updatedTodos));
        } else {
          emit(const TodosError(message: "Data is not exist"));
        }
      } catch (e) {
        emit(TodosError(message: "Failed to update todo ${e.toString()}"));
      }
    });

    on<EditTodoEvent>((event, emit) async {
      emit(const TodosLoading());
      try {
        final editedTodos =
            await _repository.editTodo(event.index, event.title);
        if (editedTodos != null) {
          emit(TodosLoaded(todos: editedTodos));
        } else {
          emit(const TodosError(message: "Data is not exist"));
        }
      } catch (e) {
        emit(TodosError(message: "Failed to edit todo ${e.toString()}"));
      }
    });

    on<DeleteTodoEvent>((event, emit) async {
      emit(const TodosLoading());
      try {
        final deleted = await _repository.deleteTodo(event.index);
        print("Todo deleted: $deleted");

        if (deleted) {
          final todos = await _repository.getAllTodos();
          print("Loaded todos after deletion: $todos");
          emit(TodosLoaded(todos: todos));
        } else {
          emit(const TodosError(message: "Failed to delete todo"));
        }
      } catch (e) {
        emit(TodosError(message: "Failed to delete todo ${e.toString()}"));
      }
    });
  }
}
