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
    if (self.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        NSLog(@"裝置為iPad");
    }
    if (self.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        NSLog(@"裝置為iPhone");
    }
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    
    if (newCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) {
        NSLog(@"Compact width");
    }
    if (newCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular) {
        NSLog(@"Regular width");
    }
    if (newCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
        NSLog(@"Compact height");
    }
    if (newCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular) {
        NSLog(@"Regular height");
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (orientation == UIDeviceOrientationLandscapeLeft) {
        NSLog(@"UIDeviceOrientationLandscapeLeft");
    }
    if (orientation == UIDeviceOrientationLandscapeRight) {
        NSLog(@"UIDeviceOrientationLandscapeRight");
    }
    if (orientation == UIDeviceOrientationPortrait) {
        NSLog(@"UIDeviceOrientationPortrait");
    }
    if (orientation == UIDeviceOrientationPortraitUpsideDown) {
        NSLog(@"UIDeviceOrientationPortraitUpsideDown");
    }
    if (orientation == UIDeviceOrientationUnknown) {
        NSLog(@"UIDeviceOrientationUnknown");
    }
    
    NSLog(@"解析度為%.f*%.0f", size.width, size.height);
}

//允許4個方向皆可以旋轉
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

@end
