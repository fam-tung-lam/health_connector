/// @docImport 'package:health_connector_core/health_connector_core_internal.dart';
///
/// iOS HealthKit implementation for health_connector.
///
/// This library provides the iOS-specific implementation of the
/// [HealthConnectorPlatformClient] interface using Apple's HealthKit framework.
/// It translates cross-platform health data models into HealthKit's native
/// types and handles iOS-specific permission flows and data synchronization.
///
/// ## Platform Requirements
///
/// - **Minimum iOS Version**: iOS 15.0+
/// - **Xcode Setup**: HealthKit capability must be enabled
/// - **Info.plist**: Usage description keys required:
///   - `NSHealthShareUsageDescription` (read access)
///   - `NSHealthUpdateUsageDescription` (write access)
///
/// ## iOS-Specific Behaviors
///
/// ### Permissions
/// - **Read permissions**: Always return [PermissionStatus.unknown] due to
///   HealthKit privacy restrictions. Apps cannot determine if read access
///   was granted.
/// - **Write permissions**: Can return `granted`/`denied` accurately.
/// - Permission dialogs are cached by iOS; subsequent requests may not
///   show the system prompt.
///
/// ### Data Immutability
/// - HealthKit uses an immutable data model - records cannot be updated
/// - To "update" data, delete the old record and write a new one
///
/// ### Background Sync
/// - HealthKit automatically syncs data from Apple Watch and other sources
/// - Apps can observe health data changes using HKObserverQuery (not yet
///   implemented in this version)
///
/// ## Main Classes
///
/// - `HealthConnectorHkClient` - iOS HealthKit client implementation
///
/// ## Usage
///
/// This plugin is automatically registered and used by `health_connector`
/// on iOS. Apps should not interact with this library directly.
///
/// ```dart
/// // Use the main SDK instead:
/// import 'package:health_connector/health_connector.dart';
///
/// final healthConnector = HealthConnector();
/// // On iOS, this automatically uses HealthConnectorHkClient internally
/// ```
///
/// ## See Also
///
/// - [Apple HealthKit Documentation](https://developer.apple.com/documentation/healthkit)
library;

import 'package:health_connector_core/health_connector_core_internal.dart';

export 'src/health_connector_hk_client.dart';
