//
//  AppDelegate.m
//  runtimeDemo
//
//  Created by hy001 on 2022/2/17.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize window = _window;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    int array[10] = {24, 17, 85, 13, 9, 54, 76, 45, 5, 63};
        
        int num = sizeof(array)/sizeof(int);
        
        for(int i = 0; i < num-1; i++) {
        
            for(int j = 0; j < num - 1 - i; j++) {
                printf("%d %d--%d\n",i, array[j], array[j+1]);

                if(array[j] < array[j+1]) {
                
                    int tmp = array[j];

                    array[j] = array[j+1];
                    
                    array[j+1] = tmp;
                    
                }
                
            }
            
        }
    for(int i = 0; i < num; i++) {
        
            printf("%d", array[i]);
            
            if(i == num-1) {
            
                printf("\n");
                
            }
            
            else {
            
                printf(" ");
                
            }
            
        }
 
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
