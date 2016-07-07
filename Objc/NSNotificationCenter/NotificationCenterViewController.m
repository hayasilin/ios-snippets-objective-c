//
//  NotificationCenterViewController.m
//  Component
//
//  Created by Kuan-Wei Lin on 7/7/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "NotificationCenterViewController.h"

@interface NotificationCenterViewController ()

@end

@implementation NotificationCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)buttonPressed:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NSNotification_Demo" object:nil];
}

- (IBAction)buttonPressedToSendNotificationWithUserInfo:(UIButton *)sender {
    NSString *str = @"Hello World!";
    
    NSDictionary *dict = @{
                           @"1": @"one",
                           @"2": @"two",
                           @"3": @"three"
                           };
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NSNotification_Demo_UserInfo_Object" object:str userInfo:dict];
}

@end
