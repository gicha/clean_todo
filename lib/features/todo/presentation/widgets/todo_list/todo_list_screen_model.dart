import 'package:elementary/elementary.dart';
import 'package:todo/features/todo/domain/bloc/task_creating/task_creating_bloc.dart';
import 'package:todo/features/todo/domain/bloc/todo_list/todo_list_bloc.dart';
import 'package:todo/features/todo/domain/bloc/todo_list/todo_list_state.dart';
import 'package:todo/features/todo/domain/dto/create_task_dto.dart';

import '../../../domain/bloc/task_creating/task_creating_event.dart';
import '../../../domain/bloc/task_creating/task_creating_state.dart';
import '../../../domain/bloc/todo_list/todo_list_event.dart';

abstract class ITodoListModel {
  void fetchTodoList();
  void addTask({
    required String title,
    required String description,
  });

  Stream<BaseTodoState> get todoListStateStream;
  Stream<BaseTaskCreatingState> get taskCreatingStateStream;
}

class TodoListModel extends ElementaryModel implements ITodoListModel {
  TodoListModel({
    required TodoListBloc todoBloc,
    required TaskCreatingBloc taskCreatingBloc,
    super.errorHandler,
  })  : _todoBloc = todoBloc,
        _taskCreatingBloc = taskCreatingBloc;

  final TodoListBloc _todoBloc;
  final TaskCreatingBloc _taskCreatingBloc;

  @override
  Stream<BaseTodoState> get todoListStateStream => _todoBloc.stream.asBroadcastStream();

  @override
  Stream<BaseTaskCreatingState> get taskCreatingStateStream => _taskCreatingBloc.stream.asBroadcastStream();

  @override
  void addTask({
    required String title,
    required String description,
  }) {
    _taskCreatingBloc.add(
      CreateTaskEvent(
        CreateTaskDTO(
          title: title,
          description: description,
        ),
      ),
    );
  }

  @override
  void fetchTodoList() {
    _todoBloc.add(LoadTodoListEvent());
  }
}
