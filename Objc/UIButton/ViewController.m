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
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, 100, 100);
    button.center = self.view.center;
    button.backgroundColor = [UIColor cyanColor];
    [button setTitle:@"Press me" forState:UIControlStateNormal];
    
    /* 下面的这个属性设置为yes的状态下，按钮按下会发光*/
    button.showsTouchWhenHighlighted = YES;
    
    //設置button圖片
    //[button setImage:[UIImage imageNamed:@"btng.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}

- (void)btnClick:(id)sender{
    NSLog(@"btnClick");
}



@end
