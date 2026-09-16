import Flutter
import UIKit
import workmanager_apple

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // iOS only accepts BGTaskScheduler launch handlers before the launch
    // finishes and BGTaskScheduler.submit crashes for an identifier without a
    // handler, so the background sync task is registered here on every launch.
    // The identifier must match BGTaskSchedulerPermittedIdentifiers and the
    // Dart WorkmanagerBackgroundSyncScheduler.taskIdentifier.
    WorkmanagerPlugin.registerPeriodicTask(
      withIdentifier: "com.phamtunglam.healthconnector.background_sync"
    )

    // Re-registers any other launch handlers persisted by earlier sessions.
    WorkmanagerPlugin.registerLaunchHandlers()

    // Background tasks run in a separate Flutter engine. Register every plugin
    // there too so health_connector and shared_preferences are reachable from
    // the background isolate.
    WorkmanagerPlugin.setPluginRegistrantCallback { registry in
      GeneratedPluginRegistrant.register(with: registry)
    }

    // workmanager_apple 0.9.x only lets its own module subclass WorkmanagerDebug,
    // so the built-in handler writes task status to the unified log
    // (`log stream --predicate 'subsystem == "..."'` or Console.app).
    WorkmanagerDebug.setCurrent(LoggingDebugHandler())

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
