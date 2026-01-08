import 'package:health_connector_core/health_connector_core_internal.dart'
    show SortDescriptor, SortDirection, sinceV3_0_0;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show SortOrderDto;
import 'package:meta/meta.dart' show internal;

/// Converts [SortDescriptor] to [SortOrderDto].
///
/// Maps the domain model (SortDescriptor with field + direction) to the
/// simplified DTO enum (SortOrderDto with combined time-direction values).
@sinceV3_0_0
@internal
extension SortDescriptorToDtoExtension on SortDescriptor {
  SortOrderDto toDto() {
    return switch (direction) {
      SortDirection.ascending => SortOrderDto.timeAscending,
      SortDirection.descending => SortOrderDto.timeDescending,
    };
  }
}
