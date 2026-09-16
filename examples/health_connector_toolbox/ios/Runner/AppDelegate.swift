import Flutter
import UIKit
import workmanager_apple

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Re-registers the BGTaskScheduler launch handlers persisted by earlier
    // sessions before the launch finishes, which iOS requires.
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
