//
//  APPChildViewController.m
//  PageControl
//
//  Created by Kuan-Wei on 2017/3/24.
//  Copyright © 2017年 TaiwanMobile. All rights reserved.
//

#import "APPChildViewController.h"

@interface APPChildViewController ()

@property (strong, nonatomic) IBOutlet UILabel *screenNumber;

@end

@implementation APPChildViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.screenNumber.text = [NSString stringWithFormat:@"Screen #%ld", (long)self.index];
}


@end
