import Foundation

/// Protocol defining a custom metadata key with type-safe value handling.
///
/// Conforming types define:
/// - The key name (with standard prefix applied automatically)
/// - The value type stored in metadata
/// - Bidirectional serialization logic
///
/// ## Usage
///
/// Define a custom key by creating an enum conforming to this protocol:
///
/// ```swift
/// enum SessionTypeKey: CustomMetadataKey {
///     typealias Value = MindfulnessSessionTypeDto
///
///     static let keySuffix = "session_type"
///
///     static func serialize(_ value: Value) -> Any {
///         value.rawValue
///     }
///
///     static func deserialize(_ rawValue: Any?) -> Value? {
///         guard let string = rawValue as? String else { return nil }
///         return Value(rawValue: string)
///     }
/// }
/// ```
///
/// Then use it with `MetadataBuilder`:
///
/// ```swift
/// var builder = MetadataBuilder(from: metadata)
/// builder.set(SessionTypeKey.self, value: .meditation)
/// let hkMetadata = builder.build()
/// ```
protocol CustomMetadataKey {
    /// The type of value this key stores in metadata.
    associatedtype Value

    /// The key suffix (e.g., "session_type"). Full key is generated
    /// by prepending `hkMetadataKeyPrefix`.
    static var keySuffix: String { get }

    /// The complete metadata key with prefix.
    ///
    /// Default implementation: `"\(hkMetadataKeyPrefix)\(keySuffix)"`
    static var fullKey: String { get }

    /// Serializes the value for storage in HKMetadata.
    ///
    /// - Parameter value: The typed value to serialize
    /// - Returns: The serialized representation (`String`, `Bool`, `Int`, etc.)
    static func serialize(_ value: Value) -> Any

    /// Deserializes from HKMetadata storage.
    ///
    /// - Parameter rawValue: The raw value from metadata dictionary
    /// - Returns: The typed value, or `nil` if deserialization fails
    static func deserialize(_ rawValue: Any?) -> Value?
}

// MARK: - Default Implementations

/// Prefix for all custom HealthKit metadata keys used by this SDK.
private let hkMetadataKeyPrefix = "\(healthConnectorIdentifier).hk_metadata_key_"

extension CustomMetadataKey {
    /// Default implementation constructs the full key from prefix and suffix.
    static var fullKey: String {
        "\(hkMetadataKeyPrefix)\(keySuffix)"
    }
}

// MARK: - Convenience Extensions

extension CustomMetadataKey {
    /// Reads the value from a metadata dictionary.
    ///
    /// - Parameter metadata: The HealthKit metadata dictionary
    /// - Returns: The deserialized value, or `nil` if key is missing or invalid
    static func read(from metadata: [String: Any]?) -> Value? {
        guard let metadata else { return nil }
        return deserialize(metadata[fullKey])
    }

    /// Writes the value to a metadata dictionary.
    ///
    /// - Parameters:
    ///   - value: The value to write
    ///   - metadata: The metadata dictionary to modify
    static func write(_ value: Value, to metadata: inout [String: Any]) {
        metadata[fullKey] = serialize(value)
    }
}
