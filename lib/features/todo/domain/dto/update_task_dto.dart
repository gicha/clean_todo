import '../entity/task_entity.dart';

class UpdateTaskDTO {
  UpdateTaskDTO({
    required this.id,
    this.title,
    this.description,
  });
  final Id id;
  final String? title;
  final String? description;
}
