// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'task_dto.dart';

class TaskDTOMapper extends ClassMapperBase<TaskDTO> {
  TaskDTOMapper._();

  static TaskDTOMapper? _instance;
  static TaskDTOMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TaskDTOMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'TaskDTO';

  static int _$id(TaskDTO v) => v.id;
  static const Field<TaskDTO, int> _f$id = Field('id', _$id);
  static String _$title(TaskDTO v) => v.title;
  static const Field<TaskDTO, String> _f$title = Field('title', _$title);
  static String _$description(TaskDTO v) => v.description;
  static const Field<TaskDTO, String> _f$description =
      Field('description', _$description);
  static bool _$active(TaskDTO v) => v.active;
  static const Field<TaskDTO, bool> _f$active = Field('active', _$active);

  @override
  final Map<Symbol, Field<TaskDTO, dynamic>> fields = const {
    #id: _f$id,
    #title: _f$title,
    #description: _f$description,
    #active: _f$active,
  };

  static TaskDTO _instantiate(DecodingData data) {
    return TaskDTO(
        id: data.dec(_f$id),
        title: data.dec(_f$title),
        description: data.dec(_f$description),
        active: data.dec(_f$active));
  }

  @override
  final Function instantiate = _instantiate;

  static TaskDTO fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TaskDTO>(map);
  }

  static TaskDTO fromJson(String json) {
    return ensureInitialized().decodeJson<TaskDTO>(json);
  }
}

mixin TaskDTOMappable {
  String toJson() {
    return TaskDTOMapper.ensureInitialized()
        .encodeJson<TaskDTO>(this as TaskDTO);
  }

  Map<String, dynamic> toMap() {
    return TaskDTOMapper.ensureInitialized()
        .encodeMap<TaskDTO>(this as TaskDTO);
  }

  TaskDTOCopyWith<TaskDTO, TaskDTO, TaskDTO> get copyWith =>
      _TaskDTOCopyWithImpl(this as TaskDTO, $identity, $identity);
  @override
  String toString() {
    return TaskDTOMapper.ensureInitialized().stringifyValue(this as TaskDTO);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            TaskDTOMapper.ensureInitialized()
                .isValueEqual(this as TaskDTO, other));
  }

  @override
  int get hashCode {
    return TaskDTOMapper.ensureInitialized().hashValue(this as TaskDTO);
  }
}

extension TaskDTOValueCopy<$R, $Out> on ObjectCopyWith<$R, TaskDTO, $Out> {
  TaskDTOCopyWith<$R, TaskDTO, $Out> get $asTaskDTO =>
      $base.as((v, t, t2) => _TaskDTOCopyWithImpl(v, t, t2));
}

abstract class TaskDTOCopyWith<$R, $In extends TaskDTO, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? id, String? title, String? description, bool? active});
  TaskDTOCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TaskDTOCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TaskDTO, $Out>
    implements TaskDTOCopyWith<$R, TaskDTO, $Out> {
  _TaskDTOCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TaskDTO> $mapper =
      TaskDTOMapper.ensureInitialized();
  @override
  $R call({int? id, String? title, String? description, bool? active}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (title != null) #title: title,
        if (description != null) #description: description,
        if (active != null) #active: active
      }));
  @override
  TaskDTO $make(CopyWithData data) => TaskDTO(
      id: data.get(#id, or: $value.id),
      title: data.get(#title, or: $value.title),
      description: data.get(#description, or: $value.description),
      active: data.get(#active, or: $value.active));

  @override
  TaskDTOCopyWith<$R2, TaskDTO, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _TaskDTOCopyWithImpl($value, $cast, t);
}
