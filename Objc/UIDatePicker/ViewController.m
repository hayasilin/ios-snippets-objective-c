//
//  ViewController.m
//  Component
//
//  Created by Kuan-Wei Lin on 6/18/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSArray *dataArray;

@property (strong, nonatomic) UIDatePicker *datePicker;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 350, self.view.frame.size.width, 216)];
    [self.view addSubview:self.datePicker];
    
    [self.datePicker addTarget:self action:@selector(datePickerValuedChange:) forControlEvents:UIControlEventValueChanged];
    
    self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    
//    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSLocale *twLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_TW"];
    self.datePicker.locale =  twLocale;
}

- (IBAction)datePickerAction:(UIDatePicker *)sender {
    NSTimeInterval n = sender.countDownDuration;
    NSLog(@"倒數計時時間為：%.0f", n);
}

- (void)datePickerValuedChange:(UIDatePicker *)sender{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy/M/d HH:mm:ss"];
    NSLog(@"The time is = %@", [format stringFromDate:sender.date]);

}


@end
