//
//  AppDelegate.m
//  Component
//
//  Created by Kuan-Wei Lin on 6/18/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "AppDelegate.h"
#import "SearchTableViewController.h"
#import "TableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window = window;
    
    TableViewController *tableViewController = [[TableViewController alloc] initWithNibName:@"TableViewController" bundle:nil];
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:tableViewController];
    
    self.window.rootViewController = navi;
    [self.window makeKeyWindow];
    
    return YES;
}

@end
