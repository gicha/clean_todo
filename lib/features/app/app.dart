import 'package:flutter/material.dart';

import '../todo/presentation/todo_widget.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const TodoWidget(),
    );
  }
}
