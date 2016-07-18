//
//  SecondViewController.m
//  Components2
//
//  Created by Kuan-Wei Lin on 7/18/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "SecondViewController.h"
#import "ViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)blockDemoAction:(UIButton *)sender {
    
    NSString *str = @"Hello world";
    
    ViewController *vc = [[ViewController alloc] init];
    [vc blockCallbackDemo:str complete:^(NSArray *arr, NSDictionary *dict) {
    
        NSLog(@"Block callback complete");
        NSLog(@"arr = %@", arr);
        NSLog(@"dict = %@", dict);
    }];
    

}

@end
