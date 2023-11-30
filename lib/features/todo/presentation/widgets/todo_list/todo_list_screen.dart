import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import 'todo_list_screen_widget_model.dart';

class TodoListScreenWidget extends ElementaryWidget<TodoListScreenWidgetModel> {
  TodoListScreenWidget({super.key}) : super(getTodoListScreenWidgetModelFactory());

  @override
  Widget build(ITodoListScreenWidgetModel wm) {
    return Container();
  }
}
