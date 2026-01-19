import Foundation
import HealthKit

// MARK: - HKCategorySample to DTO

/// Extension for mapping `HKCategorySample` → `ContraceptiveRecordDto`.
extension HKCategorySample {
    /// Converts a HealthKit contraceptive category sample to `ContraceptiveRecordDto`.
    func toContraceptiveRecordDto() throws -> ContraceptiveRecordDto {
        // Create builder from HK metadata with source and device
        var builder = MetadataBuilder(
            fromHKMetadata: metadata ?? [:],
            source: sourceRevision.source,
            device: device
        )

        // Extract timezone offsets from metadata
        let startZoneOffset = StartTimeZoneOffsetKey.read(from: builder.metadataDict)
        let endZoneOffset = EndTimeZoneOffsetKey.read(from: builder.metadataDict)

        // Convert HealthKit category value to DTO
        guard
            let hkType = HKCategoryValueContraceptive(rawValue: value)
        else {
            throw HealthConnectorError.invalidArgument(
                message: "Invalid contraceptive type value: \(value)"
            )
        }

        return try ContraceptiveRecordDto(
            id: uuid.uuidString,
            metadata: builder.toMetadataDto(),
            startTime: startDate.millisecondsSince1970,
            endTime: endDate.millisecondsSince1970,
            contraceptiveType: hkType.toContraceptiveTypeDto(),
            startZoneOffsetSeconds: startZoneOffset,
            endZoneOffsetSeconds: endZoneOffset
        )
    }
}

// MARK: - DTO to HealthKit

/// Extension for mapping `ContraceptiveRecordDto` → `HKCategorySample`.
extension ContraceptiveRecordDto {
    /// Converts a `ContraceptiveRecordDto` to a HealthKit category sample.
    func toHKCategorySample() throws -> HKCategorySample {
        guard
            let categoryType = HKObjectType.categoryType(
                forIdentifier: .contraceptive
            )
        else {
            throw HealthConnectorError.invalidArgument(
                message: "Failed to create category type for contraceptive"
            )
        }

        let startDate = Date(timeIntervalSince1970: TimeInterval(startTime) / 1000)
        let endDate = Date(timeIntervalSince1970: TimeInterval(endTime) / 1000)

        // Build metadata using centralized builder
        let builder = try MetadataBuilder(from: metadata)

        return HKCategorySample(
            type: categoryType,
            value: contraceptiveType.toHealthKit().rawValue,
            start: startDate,
            end: endDate,
            device: builder.healthDevice,
            metadata: builder.build()
        )
    }
}

// MARK: - Enum Mapping Helpers

extension HKCategoryValueContraceptive {
    /// Converts `HKCategoryValueContraceptive` to `ContraceptiveTypeDto`.
    ///
    /// The `@unknown default` case handles future HealthKit versions that might add new
    /// contraceptive types, returning `.unknown` for unrecognized values.
    func toContraceptiveTypeDto() -> ContraceptiveTypeDto {
        switch self {
        case .unspecified:
            return .unknown
        case .implant:
            return .implant
        case .injection:
            return .injection
        case .intrauterineDevice:
            return .intrauterineDevice
        case .intravaginalRing:
            return .intravaginalRing
        case .oral:
            return .oral
        case .patch:
            return .patch
        @unknown default:
            return .unknown
        }
    }
}

extension ContraceptiveTypeDto {
    /// Converts `ContraceptiveTypeDto` to `HKCategoryValueContraceptive`.
    func toHealthKit() -> HKCategoryValueContraceptive {
        switch self {
        case .unknown:
            .unspecified
        case .implant:
            .implant
        case .injection:
            .injection
        case .intrauterineDevice:
            .intrauterineDevice
        case .intravaginalRing:
            .intravaginalRing
        case .oral:
            .oral
        case .patch:
            .patch
        }
    }
}
