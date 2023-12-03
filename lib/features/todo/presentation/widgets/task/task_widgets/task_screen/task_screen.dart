import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

import '../../../../../domain/entity/task_entity.dart';
import '../../task_widget.dart';
import '../../task_widget_model.dart';
import 'widgets/task_appbar.dart';

class TaskScreen extends TaskWidget {
  TaskScreen({super.key});

  @override
  Widget build(ITaskWidgetModel wm) {
    return StateNotifierBuilder(
      listenableState: wm.deleteLoadingStatusNotifier,
      builder: (context, isDeleting) => IgnorePointer(
        ignoring: isDeleting == true,
        child: Scaffold(
          appBar: TaskAppbar(
            taskEditingStatusListenable: wm.taskEditingStatusListenable,
            titleController: wm.titleController,
            onEditTap: wm.onEditTap,
            onEditingDoneTap: wm.onEditingDoneTap,
            onCancelTap: wm.onCancelTap,
          ),
          body: Column(
            children: [
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: wm.taskEditingStatusListenable,
                  builder: (context, status, _) => TextField(
                    controller: wm.descriptionController,
                    enabled: status.data == TaskEditingStatus.editing,
                    style: Theme.of(context).textTheme.displayMedium,
                    maxLines: null,
                    textInputAction: TextInputAction.newline,
                    decoration: const InputDecoration(
                      hintText: 'Description',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(24),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: EntityStateNotifierBuilder(
                      listenableEntityState: wm.taskStatusListenable,
                      loadingBuilder: (context, _) => const TextButton(
                        onPressed: null,
                        child: SizedBox.square(
                          dimension: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                          ),
                        ),
                      ),
                      builder: (context, status) {
                        if (status == TaskStatus.active) {
                          return TextButton(
                            onPressed: wm.onCompleteTap,
                            child: const Text('Complete'),
                          );
                        } else {
                          return TextButton(
                            onPressed: wm.onRevertTap,
                            child: const Text('Activate'),
                          );
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: StateNotifierBuilder(
                      listenableState: wm.deleteLoadingStatusNotifier,
                      builder: (context, isLoading) {
                        if (isLoading == true) {
                          return const TextButton(
                            onPressed: null,
                            child: SizedBox.square(
                              dimension: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                              ),
                            ),
                          );
                        } else {
                          return TextButton(
                            onPressed: () {
                              wm.onDeleteTap();
                              Navigator.of(context).pop();
                            },
                            child: const Text('Delete'),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
