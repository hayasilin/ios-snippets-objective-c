//
//  AppDelegate.m
//  Tabbar
//
//  Created by Kuan-Wei Lin on 2/10/17.
//  Copyright © 2017 Tricella. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    FirstViewController* vc1 = [[FirstViewController alloc] init];
    SecondViewController* vc2 = [[SecondViewController alloc] init];
    FirstViewController* vc3 = [[FirstViewController alloc] init];
    SecondViewController* vc4 = [[SecondViewController alloc] init];
    
    vc1.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:1];
    vc2.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:2];
    vc3.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:3];
    vc4.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:4];
//    vc1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Home" image:[UIImage imageNamed:@"tabbar-icon-home"] tag:1];
//    vc2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Schedule" image:[UIImage imageNamed:@"tabbar-icon-schedule"] tag:2];
//    vc3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Family" image:[UIImage imageNamed:@"tabbar-icon-family"] tag:3];
//    vc4.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Schedule" image:[UIImage imageNamed:@"tabbar-icon-settings"] tag:4];
//    
    // style
    UIColor *itemColor = [UIColor colorWithRed:0.5922 green:0.5922 blue:0.5922 alpha:1.0];
    UIColor *itemSelectTintColor = [UIColor colorWithRed:0.1647 green:0.6392 blue:0.5529 alpha:1.0];
    
    [[UITabBar appearance] setTintColor:itemSelectTintColor]; // 被選擇的顏色
    
    NSDictionary *itemAttribute = @{NSForegroundColorAttributeName: itemColor};
    NSDictionary *selectedItemAttribute = @{NSForegroundColorAttributeName: itemSelectTintColor};
    
    [[UITabBarItem appearance] setTitleTextAttributes:itemAttribute forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:selectedItemAttribute forState:UIControlStateSelected];

    
    NSArray* controllers = [NSArray arrayWithObjects:vc1, vc2, vc3, vc4, nil];
    tabBarController.viewControllers = controllers;
    
    // Add the tab bar controller's current view as a subview of the window
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
