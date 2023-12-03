import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

import '../../../domain/entity/task_entity.dart';
import '../task/task_widgets/task_card/task_card.dart';
import 'todo_list_screen_widget_model.dart';

class TodoListScreenWidget extends StatelessWidget {
  const TodoListScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TaskStatus.values.length,
      child: TodoListScreen(),
    );
  }
}

class TodoListScreen extends ElementaryWidget<TodoListScreenWidgetModel> {
  TodoListScreen({super.key}) : super(getTodoListScreenWidgetModelFactory());

  @override
  Widget build(ITodoListScreenWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          tabs: [
            for (final status in TaskStatus.values)
              Tab(
                text: status.title,
              ),
          ],
        ),
      ),
      floatingActionButton: StateNotifierBuilder(
        listenableState: wm.newTaskState,
        builder: (context, state) {
          if (state == null) {
            return FloatingActionButton(
              onPressed: wm.onAddTaskTap,
              child: const Icon(Icons.add),
            );
          }
          return const FloatingActionButton(
            onPressed: null,
            child: SizedBox.square(
              dimension: 24,
              child: CircularProgressIndicator(strokeWidth: 3),
            ),
          );
        },
      ),
      body: EntityStateNotifierBuilder(
        listenableEntityState: wm.todoListenable,
        loadingBuilder: (context, _) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorBuilder: (context, error, _) => Center(
          child: Text(error.toString()),
        ),
        builder: (context, state) {
          final todoLists = state ?? {};
          return TabBarView(
            children: List.generate(
              todoLists.length,
              (index) {
                final status = todoLists.keys.toList()[index];
                final tasks = todoLists[status]!;
                if (tasks.isEmpty) {
                  return const Center(
                    child: Text('No tasks'),
                  );
                }
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[tasks.length - index - 1];
                    return TaskCard(task);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
