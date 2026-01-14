/// Extensions to provide a consistent `tag` property for logging.
///
/// This extension allows retrieving the class name as a string dynamically,
/// removing the need for manually declared static tag constants.
///
/// @internalUse
/// @nodoc
extension ObjectNameExtension on Object {
  /// Returns class name for this instance (e.g., `ClassA().tag` -> "ClassA").
  // ignore: no_runtimetype_tostring
  String get tag => runtimeType.toString();
}
