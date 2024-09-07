// import 'package:hive/hive.dart';

// part 'todo.g.dart';

// @HiveType(typeId: 1)
// class Todo extends HiveObject {
//   @HiveField(2)
//   String title;

//   @HiveField(3)
//   bool isCompleted;

//   Todo({
//     required this.title,
//     this.isCompleted = false,
//   });

//   Todo copyWith({String? title, bool? isCompleted}) {
//     return Todo(
//       title: title ?? this.title,
//       isCompleted: isCompleted ?? this.isCompleted,
//     );
//   }
// }

class Todo {
  final String id;
  final String task;
  final bool isDone;

  Todo({required this.id, required this.task, required this.isDone});

  Todo copyWith({
    String? id,
    String? task,
    bool? isDone,
  }) {
    return Todo(
      id: id ?? this.id,
      task: task ?? this.task,
      isDone: isDone ?? this.isDone,
    );
  }
}
