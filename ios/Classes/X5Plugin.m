#import "X5Plugin.h"
#import <x5_plugin/x5_plugin-Swift.h>

@implementation X5Plugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftX5Plugin registerWithRegistrar:registrar];
}
@end
