import Foundation

/// Extension to simplify millisecond timestamp conversions.
///
/// Eliminates repeated timestamp math across mapper files and provides
/// a consistent, type-safe interface for Date ↔ millisecond conversions.
extension Date {
    /// Creates a Date from milliseconds since 1970.
    ///
    /// - Parameter millisecondsSince1970: Milliseconds since Unix epoch
    init(millisecondsSince1970: Int64) {
        self.init(timeIntervalSince1970: TimeInterval(millisecondsSince1970) / 1000.0)
    }

    /// Returns milliseconds since 1970 as Int64.
    ///
    /// Useful for serializing dates to DTOs that expect millisecond timestamps.
    var millisecondsSince1970: Int64 {
        Int64(timeIntervalSince1970 * 1000)
    }
}
