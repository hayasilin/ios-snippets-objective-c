//
//  ViewController.m
//  Block
//
//  Created by kuanwei on 2020/7/28.
//  Copyright © 2020 kuanwei. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *data;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UIBarButtonItem *goNextPageButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(goNextPage)];
    self.navigationItem.rightBarButtonItem = goNextPageButton;
}

- (void) goNextPage {
    DetailViewController *detailVC = [[DetailViewController alloc] init];
        [self.navigationController pushViewController:detailVC animated:true];

    [detailVC blockCallbackDemo:@"hello" complete:^(NSArray *arr, NSDictionary *dict) {

        NSLog(@"Block callback complete");
        NSLog(@"arr = %@", arr);
        NSLog(@"dict = %@", dict);
    }];


    void(^completion)(void) = ^{
        NSLog(@"complet");
    };

    [self commonBeforeExecute:@"hello" completion:completion];


    completion();
}

- (void)commonBeforeExecute: (NSString *)str completion:(void (^)(void))completion {
    NSLog(@"commonBeforeExecute");
    completion();
}


@end
