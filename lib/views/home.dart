import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipeable_tile/swipeable_tile.dart';
import 'package:todoku_app/bloc/todos_bloc.dart';
import 'package:todoku_app/constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    context.read<TodosBloc>().add(LoadedTodosEvent());
    super.initState();
  }

  final TextEditingController _todoController = TextEditingController();
  final TextEditingController _editTodoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: BlocBuilder<TodosBloc, TodosState>(
        builder: (context, state) {
          if (state is TodosLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TodosLoaded) {
            var todos = state.todos;
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 42.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hello, Todokus",
                              style: GoogleFonts.lexendDeca(
                                  textStyle: const TextStyle(
                                      color: black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500))),
                          const SizedBox(
                            height: 6.0,
                          ),
                          Text("Today you have ${todos.length} tasks",
                              style: GoogleFonts.lexendDeca(
                                  textStyle: const TextStyle(
                                      color: black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w300)))
                        ],
                      ),
                      const CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/avatar.jpg"),
                          radius: 30.0)
                    ],
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                  todos.isEmpty
                      ? Center(
                          child: Text("No todo yet",
                              style: GoogleFonts.lexendDeca(
                                  textStyle: const TextStyle(
                                      color: black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400))),
                        )
                      : ListView.builder(
                          itemCount: todos.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var todo = todos[index];
                            return SwipeableTile.card(
                              shadow: shadow,
                              horizontalPadding: 1.0,
                              verticalPadding: 6.0,
                              color: white,
                              key: UniqueKey(),
                              onSwiped: (direction) {
                                if (direction == SwipeDirection.endToStart) {
                                  context
                                      .read<TodosBloc>()
                                      .add(DeleteTodoEvent(index: index));
                                }
                              },
                              backgroundBuilder:
                                  (context, direction, progress) {
                                if (direction == SwipeDirection.endToStart) {
                                  return Container(color: Colors.red);
                                } else if (direction ==
                                    SwipeDirection.startToEnd) {
                                  return Container(color: Colors.blue);
                                }
                                return Container();
                              },
                              child: InkWell(
                                onTap: () {
                                  _editTodoController.text = todo.title;

                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      backgroundColor: extraLightOrange,
                                      title: Text('Edit Todo',
                                          style: GoogleFonts.lexendDeca(
                                              textStyle: const TextStyle(
                                                  color: black,
                                                  fontSize: 16.0,
                                                  fontWeight:
                                                      FontWeight.w500))),
                                      content: TextField(
                                        controller: _editTodoController,
                                        decoration: const InputDecoration(
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: orange), // Default color
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text('Cancel',
                                              style: GoogleFonts.lexendDeca(
                                                  textStyle: TextStyle(
                                                      color: Colors.red[700],
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w400))),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            context.read<TodosBloc>().add(
                                                EditTodoEvent(
                                                    index: index,
                                                    title: _editTodoController
                                                        .text));
                                            Navigator.pop(context);
                                            _editTodoController.clear();
                                          },
                                          child: Text('Save',
                                              style: GoogleFonts.lexendDeca(
                                                  textStyle: const TextStyle(
                                                      color: black,
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w400))),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 4.0),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: todo.isCompleted,
                                        onChanged: (value) => context
                                            .read<TodosBloc>()
                                            .add(ToggleTodoCompletionEvent(
                                                index: index)),
                                        activeColor: orange,
                                      ),
                                      Text(todo.title,
                                          style: GoogleFonts.lexendDeca(
                                              textStyle: const TextStyle(
                                                  color: black,
                                                  fontSize: 14.0,
                                                  fontWeight:
                                                      FontWeight.w300))),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                ],
              ),
            );
          }
          if (state is TodosError) {
            return Center(child: Text(state.message)); // Show error message
          }
          return const Center(
              child: Text('No data available')); // Handle unexpected state
        },
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: orange,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: extraLightOrange,
              title: Text('Add Todo',
                  style: GoogleFonts.lexendDeca(
                      textStyle: const TextStyle(
                          color: black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500))),
              content: TextField(
                controller: _todoController,
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: orange), // Default color
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel',
                      style: GoogleFonts.lexendDeca(
                          textStyle: TextStyle(
                              color: Colors.red[700],
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400))),
                ),
                TextButton(
                  onPressed: () {
                    context
                        .read<TodosBloc>()
                        .add(AddTodoEvent(title: _todoController.text));
                    Navigator.pop(context);
                    _todoController.clear();
                  },
                  child: Text('Add',
                      style: GoogleFonts.lexendDeca(
                          textStyle: const TextStyle(
                              color: black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400))),
                ),
              ],
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: white,
          size: 24,
        ),
      ),
    );
  }
}
