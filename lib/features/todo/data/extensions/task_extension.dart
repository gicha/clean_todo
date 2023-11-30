import 'package:todo/features/todo/data/dto/task_dto.dart';
import 'package:todo/features/todo/domain/entity/task_entity.dart';

extension TaskDTOExtension on TaskDTO {
  TaskEntity get entity => TaskEntity(
        id: id,
        title: title,
        description: description,
        status: active ? TaskStatus.active : TaskStatus.completed,
      );
}

extension TaskEntityExtension on TaskEntity {
  TaskDTO get dto => TaskDTO(
        id: id,
        title: title,
        description: description,
        active: status == TaskStatus.active,
      );
}
