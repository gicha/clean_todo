import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../task_widget_model.dart';

class TaskAppbar extends StatelessWidget implements PreferredSizeWidget {
  const TaskAppbar({
    super.key,
    required this.taskEditingStatusListenable,
    required this.titleController,
    required this.onEditTap,
    required this.onEditingDoneTap,
    required this.onCancelTap,
  });

  final ValueListenable<EntityState<TaskEditingStatus>> taskEditingStatusListenable;
  final TextEditingController titleController;
  final VoidCallback onEditTap;
  final VoidCallback onEditingDoneTap;
  final VoidCallback onCancelTap;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: taskEditingStatusListenable,
      builder: (context, status, _) => AppBar(
        title: IgnorePointer(
          ignoring: status.data != TaskEditingStatus.editing,
          child: TextField(
            controller: titleController,
            enabled: status.data == TaskEditingStatus.editing,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Title',
            ),
          ),
        ),
        actions: [
          if (status.isLoadingState)
            const TextButton(
              onPressed: null,
              child: SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                ),
              ),
            )
          else if (status.data == TaskEditingStatus.editing) ...[
            TextButton(
              onPressed: onEditingDoneTap,
              child: const Text('Done'),
            ),
            TextButton(
              onPressed: onCancelTap,
              child: const Text('Cancel'),
            ),
          ] else if (status.data == TaskEditingStatus.none)
            TextButton(
              onPressed: onEditTap,
              child: const Text('Edit'),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
