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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 取得目前時間
    NSDate *date = [NSDate date];
    // 印出结果： 当前时间 date
    NSLog(@"目前時間 date = %@",date);
    
    // 獲取從某個日期開始往前或者往後多久的日期，此處60代表60秒，如果需要獲取之前的，將60改為-60即可
    date = [[NSDate alloc] initWithTimeInterval:60 sinceDate:[NSDate date]];
    
    //印出结果：當前時間 往後60s的時間
    NSLog(@"目前時間 往後60s的時間date = %@", date);
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localDate = [date  dateByAddingTimeInterval: interval];
    // 印出结果正確當前時間
    NSLog(@"正確當前當前 localDate = %@",localDate);
    
    /*----日期時間的比較----*/
    // 當前時間
    NSDate *currentDate = [NSDate date];
    
    // 比當前時間晚一個小時的時間
    NSDate *laterDate = [[NSDate alloc] initWithTimeInterval:60*60 sinceDate:[NSDate date]];
    
    // 比當前时间早一個小时的時間
    NSDate *earlierDate = [[NSDate alloc] initWithTimeInterval:-60*60 sinceDate:[NSDate date]];
    
    // 比較哪個時間晚
    if ([currentDate laterDate:laterDate]) {
        // 印出结果：current比later晚
        NSLog(@"current-%@比later-%@晚", currentDate,laterDate);
    }
    
    // 比較哪個時間早
    if ([currentDate earlierDate:earlierDate]) {
        // 印出结果：current比earlier
        NSLog(@"current-%@ 比 earlier-%@ 早", currentDate,earlierDate);
    }
    
    if ([currentDate compare:earlierDate] == NSOrderedDescending) {
        // 印出结果
        NSLog(@"current 晚");
    }
    if ([currentDate compare:currentDate] == NSOrderedSame) {
        // 印出结果
        NSLog(@"時間相等");
    }
    if ([currentDate compare:laterDate] == NSOrderedAscending) {
        // 印出结果
        NSLog(@"current 早");
    }
    
    //NSDate 轉 NSString
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    NSLog(@"%@", strDate);
    
    //NSString 轉 NSDate
    [self nsstringToNSDate];
}

- (void)nsstringToNSDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:@"2010-08-04 16:01:03"];
    NSLog(@"%@", date);
}



@end
