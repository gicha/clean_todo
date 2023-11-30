import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/todo/domain/bloc/task/task_bloc.dart';
import 'package:todo/features/todo/domain/bloc/task_creating/task_creating_bloc.dart';
import 'package:todo/features/todo/domain/bloc/todo_list/todo_list_bloc.dart';
import 'package:todo/features/todo/domain/entity/task_entity.dart';
import 'package:todo/features/todo/domain/repository/todo_repository.dart';

import '../task/task_widget.dart';
import 'todo_list_screen.dart';
import 'todo_list_screen_model.dart';

abstract class ITodoListScreenWidgetModel {
  void onAddTaskTap();
  void onTaskTap(TaskEntity task);
}

WidgetModelFactory getTodoListScreenWidgetModelFactory() => (BuildContext context) => TodoListScreenWidgetModel(
      TodoListScreenModel(
        todoBloc: context.read<TodoListBloc>(),
        taskCreatingBloc: context.read<TaskCreatingBloc>(),
      ),
    );

class TodoListScreenWidgetModel extends WidgetModel<TodoListScreenWidget, TodoListScreenModel> implements ITodoListScreenWidgetModel {
  TodoListScreenWidgetModel(super.model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
  }

  @override
  void onAddTaskTap() {
    String title = 'title';
    String description = 'description';
    model.addTask(
      title: title,
      description: description,
    );
  }

  @override
  void onTaskTap(TaskEntity task) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => TaskBloc(
            task: task,
            todoRepository: context.read<TodoRepository>(),
          ),
          child: const TaskWidget(),
        ),
      ),
    );
  }
}
