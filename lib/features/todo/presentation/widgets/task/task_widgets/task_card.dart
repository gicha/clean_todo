import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/bloc/task/task_bloc.dart';
import '../../../../domain/bloc/todo_list/todo_list_bloc.dart';
import '../../../../domain/bloc/todo_list/todo_list_event.dart';
import '../../../../domain/entity/task_entity.dart';
import '../../../../domain/repository/todo_repository.dart';
import '../task_widget.dart';
import '../task_widget_model.dart';
import 'task_screen.dart';

class TaskCard extends StatelessWidget {
  const TaskCard(this.task, {super.key});

  final TaskEntity task;

  void onCardTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TaskScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      key: ValueKey(task.id),
      create: (context) => TaskBloc(
        task: task,
        todoRepository: context.read<TodoRepository>(),
        onTaskDelete: (task) => context.read<TodoListBloc>().add(TaskDeletedListEvent(task)),
        onTaskUpdate: (task) => context.read<TodoListBloc>().add(TaskUpdatedListEvent(task)),
      ),
      child: Builder(
        builder: (context) => _TaskCard(
          onCardTap: () => onCardTap(context),
        ),
      ),
    );
  }
}

class _TaskCard extends TaskWidget {
  _TaskCard({required this.onCardTap});

  final VoidCallback onCardTap;

  @override
  Widget build(ITaskWidgetModel wm) {
    return ListTile(
      onTap: onCardTap,
      title: Text(wm.title),
      subtitle: Text(wm.description),
    );
  }
}
