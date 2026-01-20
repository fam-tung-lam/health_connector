import 'package:meta/meta.dart' show internal;
import 'package:meta/meta_meta.dart' show TargetKind, Target;

/// Internal annotation target definitions for SDK annotations.
///
/// This file defines reusable [Target] constants that restrict where specific
/// annotations can be applied in the Health Connector SDK. These targets help
/// enforce proper annotation usage at compile time.
///
/// ## Purpose
///
/// Dart's meta-annotation system allows annotations to specify which code
/// elements they can be applied to (e.g., classes, methods, fields). By
/// defining common target sets, we ensure:
/// - **Consistency**: Multiple annotations share the same target restrictions
/// - **Type safety**: Invalid annotation usage is caught at compile time
/// - **Clear intent**: Target names document annotation applicability
///
/// ## Available Target Sets
///
/// ### `allTargets`
/// Can be applied to any code element including:
/// - Classes, enums, mixins, extension types
/// - Methods, functions, getters, setters
/// - Fields, parameters, type parameters
/// - Libraries and directives
///
/// **Used by**: `@internalUse`, `@experimentalApi`, `@Since`, `@readOnly`
///
/// ### `memberAndTypeTargets`
/// Restricted to type declarations and their members:
/// - Classes, enums
/// - Methods, fields
/// - Enum values
/// - Parameters
///
/// **Used by**: `@supportedOn`
///
/// ## Example
///
/// ```dart
/// // Define an annotation with target restrictions
/// @allTargets  // Can be used on any code element
/// @internalUse
/// @immutable
/// final class MyAnnotation {
///   const MyAnnotation();
/// }
///
/// const myAnnotation = MyAnnotation();
/// ```
///
/// ## See also
///
/// - The `meta_meta` package for Dart's annotation target system
/// - Individual annotation files for specific usage examples
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

/// Target set for type declarations and their members only.
///
/// Used by annotations that apply to types and their members but not to
/// standalone functions, libraries, or other top-level constructs:
/// - `@supportedOn`: Restricts platform-specific types and methods
@internal
const memberAndTypeTargets = Target({
  TargetKind.classType,
  TargetKind.method,
  TargetKind.enumType,
  TargetKind.enumValue,
  TargetKind.field,
  TargetKind.parameter,
});
