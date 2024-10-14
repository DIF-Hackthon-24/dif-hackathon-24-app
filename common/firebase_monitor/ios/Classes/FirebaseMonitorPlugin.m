#import "FirebaseMonitorPlugin.h"
#if __has_include(<firebase_monitor/firebase_monitor-Swift.h>)
#import <firebase_monitor/firebase_monitor-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "firebase_monitor-Swift.h"
#endif

@implementation FirebaseMonitorPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFirebaseMonitorPlugin registerWithRegistrar:registrar];
}
@end
