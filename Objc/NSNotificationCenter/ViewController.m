//
//  ViewController.m
//  Component
//
//  Created by Kuan-Wei Lin on 6/18/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification) name:@"NSNotification_Demo" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotificationWithUserInfo:) name:@"NSNotification_Demo_UserInfo_Object" object:nil];
}

- (void)receiveNotification{
    NSLog(@"receiveNotification");
}

- (void)receiveNotificationWithUserInfo: (NSNotification *)notification{
    NSLog(@"receiveNotificationWithUserInfo = %@", [notification userInfo]);
    NSLog(@"receiveNotificationWithObject = %@", [notification object]);
}



@end
