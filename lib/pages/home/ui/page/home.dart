import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipeable_tile/swipeable_tile.dart';
import 'package:todoku_app/constants.dart';
import 'package:todoku_app/pages/home/bloc/todo_bloc.dart';
import 'package:todoku_app/pages/home/model/todo.dart';
import 'package:todoku_app/pages/home/ui/widget/show_dialog_unauthorized.dart';
import 'package:todoku_app/pages/login/bloc/google_auth_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    BlocProvider.of<GoogleAuthBloc>(context).add(CheckAuthStatusEvent());
    super.initState();
  }

  final TextEditingController _todoController = TextEditingController();
  final TextEditingController _editTodoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TodoBloc _todoBloc = BlocProvider.of<TodoBloc>(context);
    final GoogleAuthBloc _googleAuthBloc =
        BlocProvider.of<GoogleAuthBloc>(context);

    return BlocConsumer<GoogleAuthBloc, GoogleAuthState>(
      listener: (context, state) {
        if (state is GoogleAuthError) {
          showMyDialog(context);
        } else if (state is GoogleAuthSuccess) {
          _todoBloc.add(LoadTodosEvent());
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              if (state is TodoLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TodoLoaded) {
                final todos = state.todos;

                return Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 42.0),
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
                      ListView.builder(
                        itemCount: todos.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final todo = todos[index];
                          return SwipeableTile.card(
                            shadow: shadow,
                            horizontalPadding: 1.0,
                            verticalPadding: 6.0,
                            color: white,
                            key: UniqueKey(),
                            onSwiped: (direction) {
                              if (direction == SwipeDirection.endToStart) {
                                _todoBloc.add(DeleteTodoEvent(todo.id));
                              }
                            },
                            backgroundBuilder: (context, direction, progress) {
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
                                _editTodoController.text = todo.task;

                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor: extraLightOrange,
                                    title: Text('Edit Todo',
                                        style: GoogleFonts.lexendDeca(
                                            textStyle: const TextStyle(
                                                color: black,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w500))),
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
                                        onPressed: () => Navigator.pop(context),
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
                                          //  _todoBloc.add(event)
                                          //   Navigator.pop(context);
                                          //   _editTodoController.clear();
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
                                      value: todo.isDone,
                                      onChanged: (value) {
                                        final updatedTodo =
                                            todo.copyWith(isDone: value);
                                        _todoBloc
                                            .add(UpdateTodoEvent(updatedTodo));
                                      },
                                      activeColor: orange,
                                    ),
                                    Text(todo.task,
                                        style: GoogleFonts.lexendDeca(
                                            textStyle: const TextStyle(
                                                color: black,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w300))),
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
              } else if (state is TodoSuccess) {
                _todoBloc.add(LoadTodosEvent());
                return Container();
              } else if (state is TodoError) {
                Center(
                  child: Text(
                    state.errorMessage,
                    style: GoogleFonts.lexendDeca(
                      textStyle: const TextStyle(
                          color: black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
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
                        final authState = _googleAuthBloc.state;

                        if (authState is GoogleAuthSuccess) {
                          // If the user is authenticated, allow adding the todo
                          final newTodo = Todo(
                              id: DateTime.now().toString(),
                              task: _todoController.text,
                              isDone: false);
                          _todoBloc.add(AddTodoEvent(newTodo));
                          Navigator.pop(context);
                          _todoController.clear();
                        } else {
                          // If not authenticated, show error dialog
                          Navigator.pop(context); // Close the "Add Todo" dialog
                           showMyDialog(context);
                        }
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
      },
    );
  }
}
