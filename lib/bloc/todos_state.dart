part of 'todos_bloc.dart';

@immutable
abstract class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object?> get props => [];
}

class TodosLoading extends TodosState {
  const TodosLoading();
}

class TodosLoaded extends TodosState {
  final List<Todo> todos;

  const TodosLoaded({required this.todos});

  @override
  List<Object?> get props => [todos];
}

class TodosError extends TodosState {
  final String message;

  const TodosError({required this.message});

  @override
  List<Object?> get props => [message];
}
