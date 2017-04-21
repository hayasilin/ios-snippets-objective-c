//
//  APPViewController.m
//  PageControl
//
//  Created by Kuan-Wei on 2017/3/24.
//  Copyright © 2017年 TaiwanMobile. All rights reserved.
//

#import "APPViewController.h"
#import "APPChildViewController.h"

@interface APPViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageController;

@end

@implementation APPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
//    [[self.pageController view] setFrame:[[self view] bounds]];
    self.pageController.view.frame = CGRectMake(0, 200, CGRectGetWidth([UIScreen mainScreen].bounds), 200);
    
    APPChildViewController *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
}

- (APPChildViewController *)viewControllerAtIndex:(NSUInteger)index
{
    APPChildViewController *childViewController = [[APPChildViewController alloc] init];
    childViewController.index = index;
    
    return childViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(APPChildViewController *)viewController index];
    
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(APPChildViewController *)viewController index];
    
    
    index++;
    
    if (index == 5) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

@end
