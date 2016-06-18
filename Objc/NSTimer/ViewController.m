//
//  ViewController.m
//  Component
//
//  Created by Kuan-Wei Lin on 6/18/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.timer == nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(doSomething) userInfo:nil repeats:NO];
    }
}

- (void)doSomething{
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    NSLog(@"Timer stop");
}


@end
