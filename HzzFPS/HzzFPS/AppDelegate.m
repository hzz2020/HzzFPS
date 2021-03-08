//
//  AppDelegate.m
//  HzzFPS
//
//  Created by laolai on 2021/3/8.
//

#import "AppDelegate.h"
#import "HzzFPSStatus.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[HzzFPSStatus shareInstance] openWithHandler:^(NSInteger fpsValue) {
        NSLog(@"fpsValue = %li", (long)fpsValue);
    }];
    
    return YES;
}


@end
