import 'package:flutter/material.dart';

import '../features/todo/presentation/todo_widget.dart';
import '../theme/theme.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: AppTheme.theme,
      home: const TodoWidget(),
    );
  }
}
