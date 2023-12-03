import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../domain/bloc/task/task_bloc.dart';
import '../domain/bloc/task/task_state.dart';
import '../domain/bloc/todo_list/todo_list_bloc.dart';
import '../domain/bloc/todo_list/todo_list_event.dart';
import '../domain/entity/task_entity.dart';
import '../domain/repository/todo_repository.dart';

class TaskDependencies extends StatelessWidget {
  const TaskDependencies({
    super.key,
    required this.task,
    required this.builder,
    this.parentContext,
  });

  final BuildContext? parentContext;
  final WidgetBuilder builder;
  final TaskEntity task;

  @override
  Widget build(BuildContext context) {
    final diContext = parentContext ?? context;
    final todoListBloc = diContext.read<TodoListBloc>();
    final todoRepository = diContext.read<TodoRepository>();
    return Provider(
      create: (context) => TaskBloc(
        task: task,
        todoRepository: todoRepository,
      ),
      builder: (context, _) => BlocListener<TaskBloc, BaseTaskState>(
        bloc: context.read<TaskBloc>(),
        listenWhen: (previous, current) => current is DeletedTaskState || current is UpdatedTaskState,
        listener: (context, state) {
          if (state is DeletedTaskState) {
            todoListBloc.add(TaskDeletedListEvent(state.task.id));
          }
          if (state is UpdatedTaskState) {
            todoListBloc.add(TaskUpdatedListEvent(state.task));
          }
        },
        child: builder(context),
      ),
    );
  }
}
