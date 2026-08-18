# Core and Dart Path

This reference owns the domain model, public registration, Pigeon source, and
hand-written Dart mappers for one health data type.

## Add the core record

Create the record part under
`health_connector_core/lib/src/models/health_records/` in the matching family.
Add its `part` directive and any import to the root `health_record.dart`
library. The part file declares no imports.

A concrete record extends `InstantHealthRecord`, `IntervalHealthRecord`, or
`SeriesHealthRecord<T>`. Follow this member order: bounds, validating public
constructor, `@internalUse` factory, private unvalidated constructor, fields,
`copyWith`, equality, and `hashCode`.

The public constructor throws `ArgumentError` through the shared validation
helpers. An interval validates end after start. Bounds are named typed constants
in the field's `MeasurementUnit`; quantities are not bare doubles. Platform
mappers use the `.internal` factory so stored platform values are not
revalidated.

Update constructor, `copyWith`, equality, and hash code together for every
field. Include list equality for series data and preserve `HealthRecordId.none`
only for records not yet written.

## Register the data type

Create the matching part under `health_data_types/`. Bind
`HealthDataType<Record, Unit>` and implement only the capability interfaces the
public API supports. Then update:

1. the root `part` list and `static const` singleton;
2. `HealthDataType.values` and its stable `snake_case` id;
3. platform and version annotations plus `supportedHealthPlatforms`;
4. `HealthRecordDataTypeExtension.dataType`;
5. `DoubleToMeasurementUnit` when aggregation returns a quantity; and
6. the explicit `show` exports in `health_connector_core.dart`.

Never change an existing id; serialized sync tokens depend on it.

## Add each supported channel

In each supported platform's Pigeon input, add the record DTO,
`HealthDataTypeDto` case, and any new enum DTO. Use epoch milliseconds,
wire-safe scalar values, and `*Dto` names. Then run the root `melos run pigeon`
script; do not invoke Pigeon per package.

Under that platform package's Dart `lib/src/mappers/`, add both `toDto()` and
`toDomain()` directions plus enum mappers. Update data-type, record, identity,
request, response, permission, and sync dispatchers that select by type.

In `health_record_mapper.dart`, invoke the concrete extension explicitly:

```dart
case final StepsRecord record:
  return StepsRecordToDto(record).toDto();
```

Implicit `record.toDto()` can resolve to the dispatcher's own extension when an
import is missing and recurse at runtime. Keep enum mapping exhaustive in both
directions rather than relying on ordinal position.
