import Foundation
import HealthKit

extension MetadataDto {
    /// Creates a `MetadataBuilder` initialized with this DTO's metadata.
    ///
    /// Use this when you need to add custom metadata keys:
    /// ```swift
    /// var builder = metadata.toMetadataBuilder()
    /// builder.set(MyCustomKey.self, value: myValue)
    /// let hkMetadata = builder.build()
    /// ```
    ///
    /// - Parameters:
    ///   - startTimeZoneOffset: Optional timezone offset in seconds for the start datetime (defaults to current
    /// timezone offset)
    ///   - endTimeZoneOffset: Optional timezone offset in seconds for the end datetime (defaults to
    /// startTimeZoneOffset)
    /// - Returns: A `MetadataBuilder` initialized with base metadata
    /// - Throws: `MetadataBuilderError.invalidTimezoneOffset` if the offset is outside ±14 hours
    func toMetadataBuilder(
        startTimeZoneOffset: Int64? = nil,
        endTimeZoneOffset: Int64? = nil
    ) throws -> MetadataBuilder {
        try MetadataBuilder(
            from: self, startTimeZoneOffset: startTimeZoneOffset,
            endTimeZoneOffset: endTimeZoneOffset
        )
    }
}

extension [String: Any] {
    /// Creates a `MetadataBuilder` initialized with this dictionary.
    ///
    /// Use this builder to:
    /// - Parse metadata into a `MetadataDto`
    /// - Extract timezone offsets
    /// - Modify or add metadata keys
    func toMetadataBuilder() -> MetadataBuilder {
        MetadataBuilder(metadata: self)
    }
}
