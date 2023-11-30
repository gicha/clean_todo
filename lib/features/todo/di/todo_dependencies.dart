import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/todo/data/repository/todo_impl.dart';
import 'package:todo/features/todo/data/source/local/impl/mock_todo_lds.dart';
import 'package:todo/features/todo/domain/bloc/todo_list/todo_list_bloc.dart';

class TodoDependenciesWidget extends StatelessWidget {
  const TodoDependenciesWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final todoLDS = MockTodoLDS();
        final todoRepository = TodoRepositoryImpl(todoLDS: todoLDS);
        return TodoListBloc(todoRepository: todoRepository);
      },
      child: child,
    );
  }
}
