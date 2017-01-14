//
//  NotificationManager.h
//  PillboxBLE
//
//  Created by Kuan-Wei Lin on 1/14/17.
//  Copyright © 2017 tricella. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NotificationManager : NSObject

+ (instancetype)sharedInstance;
- (void)registerLocalNotification;
- (void)didReceiveLocalNotification:(UILocalNotification *)notification;
- (void)sendLocalNotificationReminder;

- (void)createNotificationAction;
- (void)handleActionWithIdentifier: (NSString *)identifier forLocalNotification:(UILocalNotification *)notification;

@end
