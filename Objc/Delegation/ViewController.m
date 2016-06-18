//
//  ViewController.m
//  MyDelegation
//
//  Created by Kuan-Wei Lin on 5/21/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () 

@property (strong, nonatomic) MyController *controller;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.controller = [MyController defaultController];
    self.controller.delegate = self;
    
}

//MARK: - MyControllerDelegate
- (void)beaconSDKDidCompleteUpdating{
    NSLog(@"beaconSDKDidCompleteUpdating");
}

- (void)beaconSDKDidFailUpdating: (NSError *)error
{
    NSLog(@"error = %@", error.description);
}



@end
