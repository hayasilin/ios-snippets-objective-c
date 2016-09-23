//
//  ViewController.m
//  Test
//
//  Created by Kuan-Wei Lin on 9/23/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)openInstgram
{
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://location?id=1"];
    //or instagram://user?username=johndoe
    
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
        [[UIApplication sharedApplication] openURL:instagramURL];
    }
}

@end
