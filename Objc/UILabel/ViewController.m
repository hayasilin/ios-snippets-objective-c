//
//  ViewController.m
//
//  Created by Kuan-Wei Lin on 3/5/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(100,100,100,60)];
    
    myLabel.text = @"Hello World!";
    myLabel.center = self.view.center;
    
    [self.view addSubview:myLabel];
}

@end
