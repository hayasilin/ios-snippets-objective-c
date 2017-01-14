//
//  NotificationManager.m
//  PillboxBLE
//
//  Created by Kuan-Wei Lin on 1/14/17.
//  Copyright © 2017 tricella. All rights reserved.
//

#import "NotificationManager.h"

//iPhone vibration
#import <AudioToolbox/AudioToolbox.h>

@interface NotificationManager ()

@end

@implementation NotificationManager

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
}

- (void)registerLocalNotification
{
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
}

- (void)didReceiveLocalNotification:(UILocalNotification *)notification
{
    if ([[UIApplication sharedApplication]applicationState] == UIApplicationStateActive)
    {
        NSLog(@"App在前景，顯示AlertView的Notification，並讓手機震動");
        
        [[UIApplication sharedApplication] cancelLocalNotification:notification];
        
        if ([UIApplication sharedApplication].applicationIconBadgeNumber != 0)
        {
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }
        
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//使手機震動
    }
    else
    {
        if ([UIApplication sharedApplication].applicationIconBadgeNumber != 0)
        {
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }
    }
}

- (void)sendLocalNotificationReminder
{
    NSLog(@"Send notification");
    
    UILocalNotification *note = [UILocalNotification new];
    note.alertBody = @"Local Notification";
    note.soundName = UILocalNotificationDefaultSoundName;
    
    //Set up the NSDate
    NSDate *date = [NSDate date];
    NSLog(@"系統目前時間 = %@", date);
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localDate = [date  dateByAddingTimeInterval: interval];
    NSLog(@"目前iPhone時區正確時間 localDate = %@",localDate);
    
    //Set up the custom date
    NSString *dateString = @"2017-01-14 13:31:00";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *customDate = [[NSDate alloc] init];
    customDate = [dateFormatter dateFromString:dateString];
    NSLog(@"Custom date = %@", customDate);
    
    note.fireDate = customDate;
    //note.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];

    note.applicationIconBadgeNumber = 0;
    note.category = @"CATEGORY";
    
    [[UIApplication sharedApplication] scheduleLocalNotification:note];
}

- (void)createNotificationAction
{
    UIMutableUserNotificationAction *action1 = [UIMutableUserNotificationAction new];
    action1.identifier = @"ACTION_1";
    action1.title = @"開啟";
    action1.activationMode = UIUserNotificationActivationModeForeground;
    action1.authenticationRequired = YES;
    action1.destructive = NO;
    
    UIMutableUserNotificationAction *action2 = [UIMutableUserNotificationAction new];
    action2.identifier = @"ACTION_2";
    action2.title = @"關閉";
    action2.activationMode = UIUserNotificationActivationModeBackground;
    action2.authenticationRequired = NO;
    action2.destructive = YES;
    
    UIMutableUserNotificationCategory *category = [UIMutableUserNotificationCategory new];
    category.identifier = @"CATEGORY";
    [category setActions:@[action1, action2] forContext:UIUserNotificationActionContextDefault];
    NSSet *categories = [NSSet setWithObjects:category, nil];
    
    //注意最後一個參數要填入NSSet封裝後的Categories
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound categories:categories];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
}

- (void)handleActionWithIdentifier: (NSString *)identifier forLocalNotification:(UILocalNotification *)notification
{
    if ([notification.category isEqualToString:@"CATEGORY"])
    {
        if ([identifier isEqualToString:@"ACTION_1"])
        {
            NSLog(@"Open the app");
        }
        
        if ([identifier isEqualToString:@"ACTION_2"])
        {
            if ([UIApplication sharedApplication].applicationIconBadgeNumber != 0)
            {
                [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
            }
        }
    }
}

- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSDictionary *noteDicts = userInfo[@"aps"];
    NSString *noteString = noteDicts[@"alert"];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:noteString preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"給個讚" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    
    [alertController addAction:alertAction];
    
    //顯示alertController，並適用於各種App主頁
    UIViewController *navi = [[[[UIApplication sharedApplication]delegate]window]rootViewController];
    
    //為消除在iOS 8環境下，如果呼叫presentViewController方法時會出現的console error資訊
    if([[[UIDevice currentDevice] systemVersion] floatValue] <= 9.0)
    {
        navi.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    
    [navi presentViewController:alertController animated:YES completion:nil];
}



@end
