import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoku_app/models/todo.dart';

class TodosRepository {
  final Box<Todo> _todosBox;

  TodosRepository(this._todosBox);

  Future<List<Todo>> getAllTodos() async {
    print(_todosBox.values.toList());
    return _todosBox.values.toList();
  }

  Future<bool> addTodo(String title) async {
    final todo = Todo(title: title, isCompleted: false);
    await _todosBox.add(todo);
    return true;
  }

  Future<List<Todo>?> toggleTodoCompletion(int index) async {
    final todos = _todosBox.values.toList();
    todos[index].isCompleted = !todos[index].isCompleted;
    await _todosBox.putAt(index, todos[index]);
    return todos;
  }

  Future<List<Todo>?> editTodo(int index, String title) async {
    final todos = _todosBox.values.toList();
    todos[index].title = title;
    await _todosBox.putAt(index, todos[index]);
    return todos;
  }

  Future<bool> deleteTodo(int index) async {
    await _todosBox.deleteAt(index);
    return true;
  }
}
