import 'package:flutter/material.dart';
import 'package:todo/features/todo/domain/dto/create_task_dto.dart';

class CreateTaskDialog extends StatefulWidget {
  const CreateTaskDialog({super.key});

  static Future<CreateTaskDTO?> show(BuildContext context) => showDialog(
        context: context,
        builder: (context) => const CreateTaskDialog(),
      );

  @override
  State<CreateTaskDialog> createState() => _CreateTaskDialogState();
}

class _CreateTaskDialogState extends State<CreateTaskDialog> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final descriptionFocusNode = FocusNode();

  bool isTaskValid = false;

  void onTitleChanged(String? value) {
    setState(() {
      isTaskValid = value?.trim().isNotEmpty ?? false;
    });
  }

  void onCreateTap() {
    Navigator.of(context).pop(
      CreateTaskDTO(
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Create task'),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 12,
      ),
      children: [
        TextField(
          controller: titleController,
          onEditingComplete: descriptionFocusNode.requestFocus,
          autofocus: true,
          onChanged: onTitleChanged,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            labelText: 'Title',
          ),
        ),
        TextField(
          controller: descriptionController,
          focusNode: descriptionFocusNode,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            labelText: 'Description',
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: isTaskValid ? onCreateTap : null,
              child: const Text('Create'),
            ),
          ],
        ),
      ],
    );
  }
}
