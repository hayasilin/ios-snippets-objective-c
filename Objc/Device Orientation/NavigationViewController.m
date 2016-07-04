//
//  NavigationViewController.m
//  Component
//
//  Created by Kuan-Wei Lin on 7/4/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

//如果被UINavigationController包住，一定要在UINavigationController的Class使用下列方法才可以允許4個方向皆可旋轉
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

@end
