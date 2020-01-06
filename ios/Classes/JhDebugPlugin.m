#import "JhDebugPlugin.h"
#if __has_include(<jh_debug/jh_debug-Swift.h>)
#import <jh_debug/jh_debug-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "jh_debug-Swift.h"
#endif

@implementation JhDebugPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftJhDebugPlugin registerWithRegistrar:registrar];
}
@end
