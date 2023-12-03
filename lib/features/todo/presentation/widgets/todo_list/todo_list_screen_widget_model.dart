import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/todo/presentation/dialogs/create_task_dialog.dart';

import '../../../domain/bloc/task_creating/task_creating_bloc.dart';
import '../../../domain/bloc/task_creating/task_creating_state.dart';
import '../../../domain/bloc/todo_list/todo_list_bloc.dart';
import '../../../domain/bloc/todo_list/todo_list_state.dart';
import '../../../domain/dto/create_task_dto.dart';
import '../../../domain/entity/task_entity.dart';
import 'todo_list_screen.dart';
import 'todo_list_screen_model.dart';

abstract class ITodoListScreenWidgetModel {
  ValueListenable<EntityState<Map<TaskStatus, List<TaskEntity>>>> get todoListenable;
  StateNotifier<CreateTaskDTO?> get newTaskState;

  void onAddTaskTap();
}

WidgetModelFactory getTodoListScreenWidgetModelFactory() => (BuildContext context) => TodoListScreenWidgetModel(
      TodoListScreenModel(
        todoBloc: context.read<TodoListBloc>(),
        taskCreatingBloc: context.read<TaskCreatingBloc>(),
      ),
    );

class TodoListScreenWidgetModel extends WidgetModel<TodoListScreen, TodoListScreenModel> implements ITodoListScreenWidgetModel {
  TodoListScreenWidgetModel(super.model);

  final _todoList = EntityStateNotifier<Map<TaskStatus, List<TaskEntity>>>(EntityState.loading());
  final _newTaskState = StateNotifier<CreateTaskDTO?>();

  @override
  ValueListenable<EntityState<Map<TaskStatus, List<TaskEntity>>>> get todoListenable => _todoList;

  @override
  StateNotifier<CreateTaskDTO?> get newTaskState => _newTaskState;

  StreamSubscription<BaseTodoState>? _todoListSubscription;
  StreamSubscription<BaseTaskCreatingState>? _taskCreatingSubscription;

  @override
  void initWidgetModel() {
    _todoListSubscription = model.todoListStateStream.listen(onTodoListState);
    _taskCreatingSubscription = model.taskCreatingStateStream.listen(onTaskCreatingState);
    model.fetchTodoList();
    super.initWidgetModel();
  }

  void onTodoListState([BaseTodoState? state]) {
    if (state is LoadingTodoState) {
      _todoList.loading();
    } else if (state is ContentTodoState) {
      final todoList = <TaskStatus, List<TaskEntity>>{
        TaskStatus.active: [],
        TaskStatus.completed: [],
      };
      for (final task in state.tasks) {
        switch (task.status) {
          case TaskStatus.active:
            todoList[TaskStatus.active]!.add(task);
            break;
          case TaskStatus.completed:
            todoList[TaskStatus.completed]!.add(task);
            break;
        }
      }
      _todoList.content(todoList);
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
  Future<void> onAddTaskTap() async {
    final createTaskDTO = await CreateTaskDialog.show(context);
    if (createTaskDTO != null) {
      model.addTask(
        title: createTaskDTO.title,
        description: createTaskDTO.description,
      );
    }
  }

  @override
  void dispose() {
    _todoListSubscription?.cancel();
    _taskCreatingSubscription?.cancel();
    _todoList.dispose();
    super.dispose();
  }
}
