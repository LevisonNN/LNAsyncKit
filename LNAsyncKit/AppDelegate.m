//
//  AppDelegate.m
//  LNAsyncKit
//
//  Created by Levison on 28.2.21.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    MainViewController *mainController = [[MainViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainController];
    _window.rootViewController = nav;
    [_window makeKeyAndVisible];
    
    return YES;
}

@end
