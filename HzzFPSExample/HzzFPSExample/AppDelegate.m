//
//  AppDelegate.m
//  HzzFPSExample
//
//  Created by laolai on 2021/3/8.
//

#import "AppDelegate.h"
#import "HzzFPS.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[HzzFPS shareInstance] openWithHandler:^(NSInteger fpsValue) {
        NSLog(@"fpsValue = %li", (long)fpsValue);
    }];
    return YES;
}


@end
