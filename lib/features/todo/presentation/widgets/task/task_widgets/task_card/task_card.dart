import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/bloc/task/task_bloc.dart';
import '../../../../../domain/bloc/todo_list/todo_list_bloc.dart';
import '../../../../../domain/bloc/todo_list/todo_list_event.dart';
import '../../../../../domain/entity/task_entity.dart';
import '../../../../../domain/repository/todo_repository.dart';
import '../../task_widget.dart';
import '../../task_widget_model.dart';
import '../task_screen/task_screen.dart';

class TaskCard extends StatelessWidget {
  const TaskCard(this.task, {super.key});

  final TaskEntity task;

  void onCardTap(BuildContext context) {
    final todoListBloc = context.read<TodoListBloc>();
    final taskBloc = TaskBloc(
      task: task,
      todoRepository: context.read<TodoRepository>(),
      onTaskDelete: (task) => todoListBloc.add(TaskDeletedListEvent(task)),
      onTaskUpdate: (task) => todoListBloc.add(TaskUpdatedListEvent(task)),
    );
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Provider(
          create: (context) => taskBloc,
          builder: (context, _) => TaskScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final todoListBloc = context.read<TodoListBloc>();
    return Provider(
      key: ValueKey(task),
      create: (context) => TaskBloc(
        task: task,
        todoRepository: context.read<TodoRepository>(),
        onTaskDelete: (task) => todoListBloc.add(TaskDeletedListEvent(task)),
        onTaskUpdate: (task) => todoListBloc.add(TaskUpdatedListEvent(task)),
      ),
      builder: (context, _) => _TaskCard(
        onCardTap: () => onCardTap(context),
      ),
    );
  }
}

class _TaskCard extends TaskWidget {
  _TaskCard({required this.onCardTap});

  final VoidCallback onCardTap;

  @override
  Widget build(ITaskWidgetModel wm) {
    return StateNotifierBuilder(
      listenableState: wm.deleteLoadingStatusNotifier,
      builder: (context, isDeleting) => IgnorePointer(
        ignoring: isDeleting == true,
        child: ListTile(
          enabled: isDeleting != true,
          onTap: onCardTap,
          title: Text(
            wm.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            wm.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          leading: EntityStateNotifierBuilder(
            listenableEntityState: wm.taskStatusListenable,
            loadingBuilder: (context, _) => const SizedBox.square(
              dimension: 48,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                ),
              ),
            ),
            builder: (context, status) => Checkbox(
              value: status == TaskStatus.completed,
              onChanged: (newStatus) {
                if (newStatus == true) {
                  wm.onCompleteTap();
                } else {
                  wm.onRevertTap();
                }
              },
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: wm.onDeleteTap,
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
