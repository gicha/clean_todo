import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:todo/features/todo/domain/entity/task_entity.dart';

import 'task_widget_model.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TaskStatus.values.length,
      child: Task(),
    );
  }
}

class Task extends ElementaryWidget<TaskWidgetModel> {
  Task({super.key}) : super(getTaskWidgetModelFactory());

  @override
  Widget build(ITaskWidgetModel wm) {
    return Container();
  }
}
