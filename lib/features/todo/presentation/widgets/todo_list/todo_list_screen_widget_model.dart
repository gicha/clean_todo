import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/todo/domain/bloc/todo_list/todo_list_event.dart';

import '../../../domain/bloc/task/task_bloc.dart';
import '../../../domain/bloc/task_creating/task_creating_bloc.dart';
import '../../../domain/bloc/task_creating/task_creating_state.dart';
import '../../../domain/bloc/todo_list/todo_list_bloc.dart';
import '../../../domain/bloc/todo_list/todo_list_state.dart';
import '../../../domain/dto/create_task_dto.dart';
import '../../../domain/entity/task_entity.dart';
import '../../../domain/repository/todo_repository.dart';
import '../task/task_widget.dart';
import 'todo_list_screen.dart';
import 'todo_list_screen_model.dart';

abstract class ITodoListScreenWidgetModel {
  ValueListenable<EntityState<List<TaskEntity>>> get todoListenable;
  StateNotifier<CreateTaskDTO?> get newTaskState;

  void onAddTaskTap();
  void onTaskTap(TaskEntity task);
}

WidgetModelFactory getTodoListScreenWidgetModelFactory() => (BuildContext context) => TodoListScreenWidgetModel(
      TodoListScreenModel(
        todoBloc: context.read<TodoListBloc>(),
        taskCreatingBloc: context.read<TaskCreatingBloc>(),
      ),
    );

class TodoListScreenWidgetModel extends WidgetModel<TodoListScreen, TodoListScreenModel> implements ITodoListScreenWidgetModel {
  TodoListScreenWidgetModel(super.model);

  final _todoList = EntityStateNotifier<List<TaskEntity>>(EntityState.loading());
  final _newTaskState = StateNotifier<CreateTaskDTO?>();
  late final tabController = context.read<TabController>();

  @override
  ValueListenable<EntityState<List<TaskEntity>>> get todoListenable => _todoList;

  @override
  StateNotifier<CreateTaskDTO?> get newTaskState => _newTaskState;

  BaseTodoState? lastTodoState;
  StreamSubscription<BaseTodoState>? _todoListSubscription;
  StreamSubscription<BaseTaskCreatingState>? _taskCreatingSubscription;

  @override
  void initWidgetModel() {
    _todoListSubscription = model.todoListStateStream.listen(onTodoListState);
    _taskCreatingSubscription = model.taskCreatingStateStream.listen(onTaskCreatingState);
    tabController.addListener(onTabChanged);
    super.initWidgetModel();
  }

  void onTabChanged() => onTodoListState();

  void onTodoListState([BaseTodoState? state]) {
    lastTodoState = state;
    if (state is LoadingTodoState) {
      _todoList.loading();
    } else if (state is ContentTodoState) {
      final status = TaskStatus.values[tabController.index];
      final filteredTodoList = state.tasks.where((task) => task.status == status).toList();
      _todoList.content(filteredTodoList);
    } else if (state is ErrorTodoState) {
      _todoList.error(state.error);
    }
  }

  void onTaskCreatingState(BaseTaskCreatingState state) {
    if (state is ReadyToCreateTaskState) {
      _newTaskState.accept(null);
    } else if (state is CreatingTaskState) {
      _newTaskState.accept(state.createTaskDTO);
    } else if (state is ErrorTaskCreatingState) {
      _newTaskState.accept(null);
      // TODO: show snackbar
    }
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
            onTaskDelete: (task) => context.read<TodoListBloc>().add(TaskDeletedListEvent(task)),
          ),
          child: const TaskWidget(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    tabController.removeListener(onTabChanged);
    _todoListSubscription?.cancel();
    _taskCreatingSubscription?.cancel();
    _todoList.dispose();
    super.dispose();
  }
}
