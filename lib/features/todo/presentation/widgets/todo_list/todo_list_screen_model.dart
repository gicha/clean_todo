import 'package:elementary/elementary.dart';

import '../../../domain/bloc/task_creating/task_creating_bloc.dart';
import '../../../domain/bloc/task_creating/task_creating_event.dart';
import '../../../domain/bloc/task_creating/task_creating_state.dart';
import '../../../domain/bloc/todo_list/todo_list_bloc.dart';
import '../../../domain/bloc/todo_list/todo_list_event.dart';
import '../../../domain/bloc/todo_list/todo_list_state.dart';
import '../../../domain/dto/create_task_dto.dart';

abstract class ITodoListScreenModel {
  void fetchTodoList();
  void addTask({
    required String title,
    required String description,
  });

  Stream<BaseTodoState> get todoListStateStream;
  Stream<BaseTaskCreatingState> get taskCreatingStateStream;
}

class TodoListScreenModel extends ElementaryModel implements ITodoListScreenModel {
  TodoListScreenModel({
    required TodoListBloc todoBloc,
    required TaskCreatingBloc taskCreatingBloc,
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
