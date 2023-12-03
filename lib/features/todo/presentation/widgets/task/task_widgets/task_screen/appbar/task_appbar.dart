import 'package:flutter/material.dart';

import '../../../task_widget_model.dart';

class TaskAppbar extends StatelessWidget {
  const TaskAppbar({
    super.key,
    required this.isLoading,
    required this.editingStatus,
    required this.titleController,
    required this.onEditTap,
    required this.onEditingDoneTap,
    required this.onCancelTap,
  });

  final bool isLoading;
  final TaskEditingStatus? editingStatus;
  final TextEditingController titleController;
  final VoidCallback onEditTap;
  final VoidCallback onEditingDoneTap;
  final VoidCallback onCancelTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: IgnorePointer(
        ignoring: editingStatus != TaskEditingStatus.editing,
        child: TextField(
          controller: titleController,
          enabled: editingStatus == TaskEditingStatus.editing,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Title',
            border: InputBorder.none,
          ),
        ),
      ),
      actions: [
        if (isLoading)
          const TextButton(
            onPressed: null,
            child: SizedBox.square(
              dimension: 20,
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            ),
          )
        else if (editingStatus == TaskEditingStatus.editing) ...[
          TextButton(
            onPressed: onEditingDoneTap,
            child: const Text('Done'),
          ),
          TextButton(
            onPressed: onCancelTap,
            child: const Text('Cancel'),
          ),
        ] else if (editingStatus == TaskEditingStatus.none)
          TextButton(
            onPressed: onEditTap,
            child: const Text('Edit'),
          ),
      ],
    );
  }
}
