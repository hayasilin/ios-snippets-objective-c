//
//  DetailViewController.m
//  Block
//
//  Created by kuanwei on 2020/7/28.
//  Copyright © 2020 kuanwei. All rights reserved.
//

#import "DetailViewController.h"
#import "SomeViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)dealloc
{
    NSLog(@"DetailViewController dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor grayColor];
    UIBarButtonItem *goNextPageButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(goNextPage)];
    self.navigationItem.rightBarButtonItem = goNextPageButton;

    self.data = @[@"apple", @"Apple", @"Orange"];
}

- (void) goNextPage {
    SomeViewController *someVC = [[SomeViewController alloc] init];

    [self presentViewController:someVC animated:true completion:^{
        self.data = someVC.data;
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)blockCallbackDemo:(NSString *)str complete:(void(^)(NSArray *arr, NSDictionary *dict))completeHandler{

    NSArray *arrDemo = @[@"1", @"2", @"3"];
    NSDictionary *dictDemo = @{
                               @"1":@"one",
                               @"2":@"two",
                               @"3":@"three"};

    completeHandler(arrDemo, dictDemo);
}

@end
