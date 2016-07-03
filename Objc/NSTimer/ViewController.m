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
    
    //No userInfo
    if (self.timer == nil) {
        NSLog(@"Timer start!");
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timesUp) userInfo:nil repeats:NO];
    }
    
    //Has userInfo
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(CGRectGetMidX(self.view.bounds) - 100, CGRectGetMidY(self.view.bounds), 200, 40);
    [button setTitle:@"Press to start timer" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)timesUp{
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    NSLog(@"Times up!");
}

- (void)buttonPressed{
    if (self.timer == nil) {
        NSLog(@"Timer start!");
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:self forKey:@"target"];
        [dict setObject:NSStringFromSelector(@selector(timerStop)) forKey:@"selector"];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerWithUserInfo:) userInfo:dict repeats:NO];
    }
}

- (void)timerWithUserInfo:(NSTimer *)timer{
    NSLog(@"Times up!");
    
    NSDictionary *dict = [timer userInfo];
    NSLog(@"dict, %@", dict);

    SEL selector = NSSelectorFromString([dict objectForKey:@"selector"]);
    [self performSelector:selector withObject:nil afterDelay:0];
}

- (void)timerStop{
    NSLog(@"Timer stop!");
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
