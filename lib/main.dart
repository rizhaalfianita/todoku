import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoku_app/lc.dart';
import 'package:todoku_app/pages/home/bloc/todo_bloc.dart';
import 'package:todoku_app/pages/login/bloc/google_auth_bloc.dart';
import 'package:todoku_app/pages/splash/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todoku_app/repository/auth_repository.dart';
import 'package:todoku_app/repository/todos_repository.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => GoogleAuthBloc(AuthRepository()),
      ),
      BlocProvider(
        create: (context) => TodoBloc(TodoRepository()),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Splash(),
    );
  }
}
