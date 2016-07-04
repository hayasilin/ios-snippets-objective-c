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

@end

@implementation ViewController

- (void)viewDidLoad {
    self.dataArray = @[@"漢堡", @"居酒屋", @"和食", @"拉麵", @"丼飯"];
}

- (IBAction)generateRandomValue:(id)sender {
    //亂數產生1~100的數值，總共100個數字變化
    u_int32_t n = arc4random() % 100 + 1;
    NSLog(@"%u", n);
}

- (IBAction)generateRandomValueFromArray:(id)sender {
    //亂數產生0~4的數值，總購5個數字變化
    u_int32_t n = arc4random() % 5;
    int i = (int)n;
    NSLog(@"%u", n);
    NSLog(@"%@", self.dataArray[i]);
}



@end
