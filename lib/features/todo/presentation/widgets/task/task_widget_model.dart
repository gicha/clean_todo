import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/todo/domain/bloc/task/task_state.dart';

import '../../../domain/bloc/task/task_bloc.dart';
import '../../../domain/entity/task_entity.dart';
import '../task/task_widget.dart';
import 'task_model.dart';

enum TaskEditingStatus {
  editing,
  none,
}

abstract class ITaskWidgetModel {
  ValueListenable<EntityState<TaskEditingStatus>> get taskEditingStatusListenable;
  ValueListenable<EntityState<TaskStatus>> get taskStatusListenable;
  StateNotifier<bool> get deleteLoadingStatusNotifier;
  TextEditingController get titleController;
  TextEditingController get descriptionController;

  void onEditTap();
  void onEditingDoneTap();
  void onCancelTap();
  void onCompleteTap();
  void onRevertTap();
}

WidgetModelFactory getTaskWidgetModelFactory() => (BuildContext context) => TaskWidgetModel(
      TaskModel(taskBloc: context.read<TaskBloc>()),
    );

class TaskWidgetModel extends WidgetModel<Task, TaskModel> implements ITaskWidgetModel {
  TaskWidgetModel(super.model);

  final _taskEditingStatus = EntityStateNotifier<TaskEditingStatus>(EntityState.content(TaskEditingStatus.none));
  final _taskStatus = EntityStateNotifier<TaskStatus>(EntityState.loading());
  final _deleteLoadingStatus = StateNotifier<bool>(initValue: false);
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  late TaskEntity cachedTask;
  StreamSubscription<BaseTaskState>? _todoListSubscription;

  @override
  ValueListenable<EntityState<TaskEditingStatus>> get taskEditingStatusListenable => _taskEditingStatus;

  @override
  ValueListenable<EntityState<TaskStatus>> get taskStatusListenable => _taskStatus;

  @override
  StateNotifier<bool> get deleteLoadingStatusNotifier => _deleteLoadingStatus;

  @override
  TextEditingController get titleController => _titleController;

  @override
  TextEditingController get descriptionController => _descriptionController;

  @override
  void initWidgetModel() {
    _todoListSubscription = model.taskStateStream.listen(onTodoListState);
    model.taskStateStream.last.then(onTodoListState);
    super.initWidgetModel();
  }

  void onTodoListState(BaseTaskState state) {
    if (state is IEditingTaskAvailable) {
      _taskEditingStatus.content(TaskEditingStatus.none);
    }
    if (state is IStatusChangingTaskAvailable) {
      _taskStatus.content(state.task.status);
    }
    if (state is IDeletingTaskAvailable) {
      _deleteLoadingStatus.accept(false);
    }
    if (state is UpdateLoadingTaskState) {
      _taskEditingStatus.loading();
    } else if (state is NewStatusLoadingTaskState) {
      _taskStatus.loading();
    } else if (state is ContentTaskState) {
      updateControllersByTask(state.task);
    } else if (state is ErrorTaskState) {
      //TODO: show error
    }
  }

  void updateControllersByTask(TaskEntity task) {
    _titleController.text = task.title;
    _descriptionController.text = task.description;
  }

  @override
  void onCancelTap() {
    _taskEditingStatus.content(TaskEditingStatus.none);
  }

  @override
  void onEditTap() {
    _taskEditingStatus.content(TaskEditingStatus.editing);
  }

  @override
  void onEditingDoneTap() {
    // TODO: add validation
    model.updateTask(
      id: cachedTask.id,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
    );
  }

  @override
  void onCompleteTap() {
    model.completeTask(cachedTask.id);
  }

  @override
  void onRevertTap() {
    model.revertTask(cachedTask.id);
  }

  @override
  void dispose() {
    _todoListSubscription?.cancel();
    _taskEditingStatus.dispose();
    _taskStatus.dispose();
    _deleteLoadingStatus.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
