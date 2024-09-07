import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoku_app/pages/home/model/todo.dart';

class TodoRepository {
  final CollectionReference _todosCollection =
      FirebaseFirestore.instance.collection('todos');

  Stream<List<Todo>> getTodos() {
    return _todosCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Todo(
          id: doc.id,
          task: data['task'],
          isDone: data['isDone'],
        );
      }).toList();
    });
  }

  Future<void> addTodo(Todo todo) {
    return _todosCollection.add({
      'task': todo.task,
      'isDone': todo.isDone,
    });
  }

  Future<void> updateTodo(Todo todo) {
    return _todosCollection.doc(todo.id).update({
      'task': todo.task,
      'isDone': todo.isDone,
    });
  }

  Future<void> deleteTodo(String todoId) {
    return _todosCollection.doc(todoId).delete();
  }
}
