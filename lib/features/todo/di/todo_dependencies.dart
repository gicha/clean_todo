import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/features/todo/data/repository/todo_impl.dart';
import 'package:todo/features/todo/data/source/local/impl/mock_todo_lds.dart';
import 'package:todo/features/todo/domain/bloc/task_creating/task_creating_bloc.dart';
import 'package:todo/features/todo/domain/bloc/todo_list/todo_list_bloc.dart';
import 'package:todo/features/todo/domain/repository/todo_repository.dart';

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
          create: (context) {
            final todoRepository = context.read<TodoRepository>();
            return TodoListBloc(todoRepository: todoRepository);
          },
        ),
        Provider(
          create: (context) {
            final todoRepository = context.read<TodoRepository>();
            final todoListBloc = context.read<TodoListBloc>();
            return TaskCreatingBloc(
              todoRepository: todoRepository,
              onTaskCreated: todoListBloc.taskCreated,
            );
          },
        ),
      ],
      builder: (context, child) => builder(context),
    );
  }
}
