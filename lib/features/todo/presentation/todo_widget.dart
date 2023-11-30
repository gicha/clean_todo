import 'package:flutter/material.dart';
import 'package:todo/features/todo/di/todo_dependencies.dart';
import 'package:todo/features/todo/presentation/widgets/todo_list/todo_list_screen.dart';

class TodoWidget extends StatelessWidget {
  const TodoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TodoDependenciesWidget(
      builder: (context) => TodoListScreenWidget(),
    );
  }
}
