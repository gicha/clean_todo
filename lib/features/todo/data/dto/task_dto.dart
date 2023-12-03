import 'package:dart_mappable/dart_mappable.dart';

import '../../domain/entity/task_entity.dart';

part 'task_dto.mapper.dart';

@MappableClass()
class TaskDTO with TaskDTOMappable {
  TaskDTO({
    required this.id,
    required this.title,
    required this.description,
    required this.active,
  });

  factory TaskDTO.fromEntity(TaskEntity entity) => TaskDTO(
        id: entity.id,
        title: entity.title,
        description: entity.description,
        active: entity.status == TaskStatus.active,
      );

  final int id;
  final String title;
  final String description;
  final bool active;

  TaskEntity get entity => TaskEntity(
        id: id,
        title: title,
        description: description,
        status: active ? TaskStatus.active : TaskStatus.completed,
      );
}
