import '../entity/task_entity.dart';

class UpdateTaskDTO {
  final Id id;
  final String title;
  final String description;

  UpdateTaskDTO({
    required this.id,
    required this.title,
    required this.description,
  });
}
