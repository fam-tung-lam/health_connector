import 'package:meta/meta.dart' show internal;
import 'package:meta/meta_meta.dart' show TargetKind, Target;

@internal
const allTargets = Target({
  TargetKind.classType,
  TargetKind.constructor,
  TargetKind.directive,
  TargetKind.enumType,
  TargetKind.enumValue,
  TargetKind.extension,
  TargetKind.extensionType,
  TargetKind.field,
  TargetKind.function,
  TargetKind.library,
  TargetKind.getter,
  TargetKind.method,
  TargetKind.mixinType,
  TargetKind.optionalParameter,
  TargetKind.overridableMember,
  TargetKind.parameter,
  TargetKind.setter,
  TargetKind.topLevelVariable,
  TargetKind.type,
  TargetKind.typedefType,
  TargetKind.typeParameter,
});

@internal
const memberAndTypeTargets = Target({
  TargetKind.classType,
  TargetKind.method,
  TargetKind.enumType,
  TargetKind.enumValue,
  TargetKind.field,
  TargetKind.parameter,
});
