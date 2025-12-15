import Foundation

/// Protocol to automatically provide a logging tag based on the class name.
///
/// This protocol extension provides a "Swifty" way to get a standardized tag
/// for logging, avoiding the need to manually define "TAG" constants.
protocol Taggable {
    static var tag: String { get }
}

/// Default implementation for Taggable.
///
/// Returns the class name as the tag.
extension Taggable {
    static var tag: String {
        String(describing: self)
    }
}

/// Make all NSObject subclasses conform to Taggable automatically.
///
/// This covers standard iOS classes like UIView, UIViewController, etc.
extension NSObject: Taggable {
}
