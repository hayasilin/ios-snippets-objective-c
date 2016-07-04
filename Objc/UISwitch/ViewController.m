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
    
    self.uiSwitch.tintColor = [UIColor redColor];
    self.uiSwitch.onTintColor = [UIColor cyanColor];// 在oneSwitch开启的状态显示的颜色 默认是GreenColor
    self.uiSwitch.thumbTintColor = [UIColor yellowColor]; // 设置开关上左右滑动的小圆点的颜色
    
//    [self.uiSwitch addTarget:self action:@selector(testModeSwitchAction:) forControlEvents:UIControlEventValueChanged]; // 添加事件监听器的方法
    
    if (self.uiSwitch.on) {
        NSLog(@"The switch is on!");
        [self.uiSwitch setOn:NO animated:YES];
    }else{
        NSLog(@"The switch is off!");
        [self.uiSwitch setOn:YES animated:YES];
    }
}

- (IBAction)testModeSwitchAction:(UISwitch *)sender {
    if (sender.on) {
        NSLog(@"The switch is on!");
    }else{
        NSLog(@"The switch is off!");
    }
}

@end
