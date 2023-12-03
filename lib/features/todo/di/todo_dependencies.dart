import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo/features/todo/domain/bloc/task_creating/task_creating_state.dart';

import '../data/repository/todo_impl.dart';
import '../data/source/local/impl/mock_todo_lds.dart';
import '../domain/bloc/task_creating/task_creating_bloc.dart';
import '../domain/bloc/todo_list/todo_list_bloc.dart';
import '../domain/bloc/todo_list/todo_list_event.dart';
import '../domain/repository/todo_repository.dart';

class TodoDependenciesWidget extends StatelessWidget {
  const TodoDependenciesWidget({
    super.key,
    required this.builder,
  });

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<TodoRepository>(
          create: (context) {
            final todoLDS = MockTodoLDS();
            return TodoRepositoryImpl(todoLDS: todoLDS);
          },
        ),
        Provider(
          create: (context) => TodoListBloc(
            todoRepository: context.read<TodoRepository>(),
          ),
        ),
        Provider(
          create: (context) => TaskCreatingBloc(
            todoRepository: context.read<TodoRepository>(),
          ),
        ),
      ],
      builder: (context, child) => BlocListener<TaskCreatingBloc, BaseTaskCreatingState>(
        bloc: context.read<TaskCreatingBloc>(),
        listener: (context, state) {
          if (state is CreatedTaskState) {
            context.read<TodoListBloc>().add(TaskCreatedListEvent(state.task));
          }
        },
        child: builder(context),
      ),
    );
  }
}
