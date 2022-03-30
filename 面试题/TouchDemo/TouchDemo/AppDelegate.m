//
//  AppDelegate.m
//  TouchDemo
//
//  Created by zjy on 2022/3/22.
//

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[TopWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor greenColor];
    self.window.rootViewController = [ViewController new];
    [self.window makeKeyAndVisible];
    return YES;
}


#pragma mark - UISceneSession lifecycle






@end
