import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:todo/features/todo/domain/entity/task_entity.dart';

import 'todo_list_screen_widget_model.dart';

class TodoListScreenWidget extends StatelessWidget {
  const TodoListScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TaskStatus.values.length,
      child: TodoListScreen(),
    );
  }
}

class TodoListScreen extends ElementaryWidget<TodoListScreenWidgetModel> {
  TodoListScreen({super.key}) : super(getTodoListScreenWidgetModelFactory());

  @override
  Widget build(ITodoListScreenWidgetModel wm) {
    return Container();
  }
}
