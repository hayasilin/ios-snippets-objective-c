//
//  AppDelegate.m
//
//  Created by Kuan-Wei Lin on 3/5/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "AppDelegate.h"
#import "TableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    TableViewController *tableViewController = [[TableViewController alloc] initWithNibName:@"TableViewController" bundle:nil];
    self.window.rootViewController = tableViewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
