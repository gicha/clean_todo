import 'package:flutter/material.dart';
import 'package:todo/features/todo/di/todo_dependencies.dart';
import 'package:todo/features/todo/presentation/widgets/todo_list/todo_list_widget.dart';

class TodoWidget extends StatelessWidget {
  const TodoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const TodoDependenciesWidget(
      child: TodoListWidget(),
    );
  }
}
