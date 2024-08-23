part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();
}

class LoadedTodosEvent extends TodosEvent {
  @override
  List<Object?> get props => [];
}

class AddTodoEvent extends TodosEvent {
  final String title;

  const AddTodoEvent({required this.title});

  @override
  List<Object?> get props => [title];
}

class ToggleTodoCompletionEvent extends TodosEvent {
  final int index;

  const ToggleTodoCompletionEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class DeleteTodoEvent extends TodosEvent {
  final int index;

  const DeleteTodoEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class EditTodoEvent extends TodosEvent {
  final int index;
  final String title;

  const EditTodoEvent({required this.index, required this.title});

  @override
  List<Object?> get props => [index, title];
}
