import 'package:flutter/material.dart';

import '../di/todo_dependencies.dart';
import 'widgets/todo_list/todo_list_screen.dart';

class TodoWidget extends StatelessWidget {
  const TodoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TodoDependenciesWidget(
      builder: (context) => const TodoListScreenWidget(),
    );
  }
}
