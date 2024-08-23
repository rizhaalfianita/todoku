import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 1)
class Todo extends HiveObject {
  @HiveField(2)
  String title;

  @HiveField(3)
  bool isCompleted;

  Todo({
    required this.title,
    this.isCompleted = false,
  });

  Todo copyWith({String? title, bool? isCompleted}) {
    return Todo(
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
