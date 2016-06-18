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
    
    UIView *view1 = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIView *view2 = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIView *view3 = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    view1.backgroundColor = [UIColor redColor];
    view2.backgroundColor = [UIColor yellowColor];
    view3.backgroundColor = [UIColor blueColor];
    
    //新增view, 到最上層
    [self.view addSubview:view1];
    [self.view addSubview:view2];
    
     //移到最下層
    [self.view sendSubviewToBack:view1];

     //移到最上層
    [self.view bringSubviewToFront:view1];
     
     //移到第99層
    [self.view insertSubview:view3 atIndex:99];
     
     //移到view2下層
    [self.view insertSubview:view1 belowSubview:view2];
     
     //移到view2上層
    [self.view insertSubview:view1 aboveSubview:view2];
     
     //刪除view
    [view1 removeFromSuperview];
    [view3 removeFromSuperview];
}

@end
