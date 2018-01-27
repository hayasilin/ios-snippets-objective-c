//
//  AppDelegate.h
//  iOS native Json
//
//  Created by Kuan-Wei Lin on 3/6/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputViewController.h"
#import "NewsTableViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) InputViewController *inputViewController;
@property (strong, nonatomic) NewsTableViewController *newsVC;

@property (nonatomic, strong) NSString *taipeiUrl;
@property (nonatomic, strong) NSMutableArray *newsArray;
@property (strong, nonatomic) NSMutableArray *urlArray;

@end

