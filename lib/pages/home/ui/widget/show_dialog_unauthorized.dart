import 'package:flutter/material.dart';
import 'package:todoku_app/pages/login/ui/page/login.dart';

Future<void> showMyDialog(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Unauthorized'),
        content: const Text('You must log in to add a todo.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: ((context) => const Login())),
                (route) => false,
              );
            },
            child: const Text('Okay'),
          ),
        ],
      );
    },
  );
}
